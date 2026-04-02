import 'package:bluppi/application/providers/user/edit_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/domain/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  final UserModel user;
  const EditProfileForm({super.key, required this.user});

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _bioController;
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _bioController = TextEditingController(text: widget.user.bio);
    _selectedGender = widget.user.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(editProfileProvider.notifier);
    final editState = ref.watch(editProfileProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Profile Picture ──
          Center(
            child: Stack(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: BluppiColors.surfaceRaised,
                      width: 3,
                    ),
                    image: DecorationImage(
                      image: widget.user.profilePic.isNotEmpty
                          ? CachedNetworkImageProvider(widget.user.profilePic)
                          : const AssetImage('assets/images/default_profile.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: BluppiColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: BluppiColors.surface,
                        width: 2,
                      ),
                    ),
                    child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ── Name Field ──
          _buildLabel('Display Name'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _nameController,
            hint: 'Your display name',
            onChanged: (v) => notifier.updateName(v),
          ),
          const SizedBox(height: 24),

          // ── Bio Field ──
          _buildLabel('Bio'),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _bioController,
            hint: 'Tell people about yourself...',
            maxLines: 4,
            maxLength: 200,
            onChanged: (v) => notifier.updateBio(v),
          ),
          const SizedBox(height: 24),

          // ── Gender ──
          _buildLabel('Gender'),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildGenderChip('Male', Icons.male, notifier),
              const SizedBox(width: 12),
              _buildGenderChip('Female', Icons.female, notifier),
              const SizedBox(width: 12),
              _buildGenderChip('Other', Icons.transgender, notifier),
            ],
          ),
          const SizedBox(height: 32),

          // ── Non-editable fields ──
          _buildLabel('Username'),
          const SizedBox(height: 8),
          _buildReadOnlyField('@${widget.user.username}'),
          const SizedBox(height: 24),

          _buildLabel('Email'),
          const SizedBox(height: 8),
          _buildReadOnlyField(widget.user.email),
          const SizedBox(height: 24),

          // ── Error message ──
          if (editState.status == EditProfileStatus.error && editState.errorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BluppiColors.error.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                editState.errorMessage!,
                style: const TextStyle(color: BluppiColors.error, fontSize: 13),
              ),
            ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: BluppiColors.textDisabled,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      style: const TextStyle(color: BluppiColors.textPrimary, fontSize: 15),
      cursorColor: BluppiColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: BluppiColors.textDisabled),
        counterStyle: const TextStyle(color: BluppiColors.textDisabled, fontSize: 11),
        filled: true,
        fillColor: BluppiColors.surfaceRaised,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: BluppiColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildReadOnlyField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: BluppiColors.surfaceRaised.withAlpha(120),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: BluppiColors.textDisabled, fontSize: 15),
            ),
          ),
          const Icon(Icons.lock_outline, size: 16, color: BluppiColors.textDisabled),
        ],
      ),
    );
  }

  Widget _buildGenderChip(String label, IconData icon, EditProfileNotifier notifier) {
    final isSelected = _selectedGender.toLowerCase() == label.toLowerCase();
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedGender = label);
          notifier.updateGender(label);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? BluppiColors.primary.withAlpha(30) : BluppiColors.surfaceRaised,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? BluppiColors.primary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? BluppiColors.primary : BluppiColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? BluppiColors.primary : BluppiColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
