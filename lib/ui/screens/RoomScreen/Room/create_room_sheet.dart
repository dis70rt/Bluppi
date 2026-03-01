import 'dart:ui';
import 'package:bluppi/application/providers/room/create_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluppiColors {
  static const surface = Color(0xFF1E1E1E);
  static const accent = Color(0xFF6C63FF);
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.grey;
  static const divider = Colors.white24;
  static const error = Colors.redAccent;
}

class CreateRoomBottomSheet extends ConsumerStatefulWidget {
  const CreateRoomBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => const CreateRoomBottomSheet(),
    );
  }

  @override
  ConsumerState<CreateRoomBottomSheet> createState() =>
      _CreateRoomBottomSheetState();
}

class _CreateRoomBottomSheetState extends ConsumerState<CreateRoomBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitRoom() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();

      final notifier = ref.read(createRoomProvider.notifier);

      notifier.updateName(_nameController.text);
      notifier.createRoom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final bottomSafe = MediaQuery.paddingOf(context).bottom;

    final state = ref.watch(createRoomProvider);
    final notifier = ref.read(createRoomProvider.notifier);

    ref.listen<CreateRoomState>(createRoomProvider, (previous, next) {
      if (previous?.isLoading == true && next.isLoading == false) {
        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              behavior: SnackBarBehavior.floating,
              backgroundColor: BluppiColors.error,
            ),
          );
        } else {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Room "${next.name}" created!'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: BluppiColors.accent,
            ),
          );
        }
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
        padding: EdgeInsets.only(
          bottom: bottomInset > 0 ? bottomInset + 20 : bottomSafe + 20,
          left: 16,
          right: 16,
          top: 60,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            color: BluppiColors.surface.withAlpha((0.90 * 255).toInt()),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        height: 5,
                        width: 48,
                        decoration: BoxDecoration(
                          color: BluppiColors.divider.withAlpha(150),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Room',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BluppiColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: BluppiColors.textSecondary,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white.withAlpha(20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(color: BluppiColors.divider, height: 1),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SectionHeader(
                              title: 'IDENTITY',
                              color: BluppiColors.accent,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _nameController,
                              focusNode: _focusNode,
                              onChanged: notifier.updateName,
                              style: const TextStyle(
                                color: BluppiColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              cursorColor: BluppiColors.accent,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                  CreateRoomState.maxNameLength,
                                ),
                              ],
                              decoration: InputDecoration(
                                hintText: 'e.g. Lofi Study Session',
                                hintStyle: TextStyle(
                                  color: BluppiColors.textSecondary.withAlpha(
                                    100,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.black.withAlpha(60),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: BluppiColors.accent,
                                    width: 1.5,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.music_note_rounded,
                                  color: BluppiColors.textSecondary,
                                ),

                                errorText:
                                    state.error != null &&
                                        state.error!.contains('Max')
                                    ? state.error
                                    : null,

                                suffixText:
                                    '${state.name.length}/${CreateRoomState.maxNameLength}',
                                suffixStyle: TextStyle(
                                  color: BluppiColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),

                              validator: (val) =>
                                  val != null && val.trim().isNotEmpty
                                  ? null
                                  : 'Name required',
                            ),

                            const SizedBox(height: 24),

                            const _SectionHeader(
                              title: 'ACCESS',
                              color: BluppiColors.accent,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _SelectionTile(
                                    title: 'Public',
                                    icon: Icons.public,
                                    isSelected: state.isPublic,
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      notifier.setPublic();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SelectionTile(
                                    title: 'Private',
                                    icon: Icons.lock_outline,
                                    isSelected: !state.isPublic,
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      notifier.setPrivate();
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            Container(
                              decoration: BoxDecoration(
                                color: state.inviteOnly
                                    ? BluppiColors.accent.withAlpha(30)
                                    : Colors.black.withAlpha(60),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: state.inviteOnly
                                      ? BluppiColors.accent.withAlpha(100)
                                      : Colors.transparent,
                                ),
                              ),
                              child: SwitchListTile.adaptive(
                                title: const Text(
                                  'Invite Only',
                                  style: TextStyle(
                                    color: BluppiColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: const Text(
                                  'Require a code to join',
                                  style: TextStyle(
                                    color: BluppiColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                value: state.inviteOnly,
                                activeThumbColor: BluppiColors.accent,
                                activeTrackColor: BluppiColors.accent.withAlpha(
                                  100,
                                ),
                                inactiveThumbColor: BluppiColors.textSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                onChanged: (val) {
                                  HapticFeedback.lightImpact();
                                  notifier.toggleInviteOnly(val);
                                },
                              ),
                            ),

                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: FilledButton(
                                onPressed: state.isLoading ? null : _submitRoom,
                                style: FilledButton.styleFrom(
                                  backgroundColor: BluppiColors.accent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: state.isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        'Create Room',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.labelSmall?.copyWith(
        color: color.withAlpha(200),
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _SelectionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? BluppiColors.accent.withAlpha(40)
              : Colors.black.withAlpha(60),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? BluppiColors.accent : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? BluppiColors.accent
                  : BluppiColors.textSecondary,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? BluppiColors.accent
                    : BluppiColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
