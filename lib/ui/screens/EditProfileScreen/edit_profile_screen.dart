import 'package:bluppi/application/providers/user/edit_profile_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/EditProfileScreen/widgets/edit_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('No user data', style: TextStyle(color: BluppiColors.textSecondary))),
          );
        }

        if (!_initialized) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(editProfileProvider.notifier).init(user);
          });
          _initialized = true;
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => context.pop(),
            ),
            title: const Text('Edit Profile'),
            centerTitle: false,
            actions: [
              _SaveButton(),
            ],
          ),
          body: EditProfileForm(user: user),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(color: BluppiColors.primary)),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e', style: const TextStyle(color: BluppiColors.error))),
      ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(editProfileProvider.select((s) => s.status));
    final isSaving = status == EditProfileStatus.saving;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: TextButton(
        onPressed: isSaving
            ? null
            : () async {
                final success = await ref.read(editProfileProvider.notifier).save();
                if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated!'),
                      backgroundColor: BluppiColors.surfaceRaised,
                    ),
                  );
                  context.pop();
                }
              },
        child: isSaving
            ? const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: BluppiColors.primary),
              )
            : const Text(
                'Save',
                style: TextStyle(
                  color: BluppiColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
