import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/widgets/avatar_picker.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/widgets/date_of_birth.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/widgets/gender_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdentityStep extends ConsumerStatefulWidget {
  const IdentityStep({super.key});

  @override
  ConsumerState<IdentityStep> createState() => _IdentityStepState();
}

class _IdentityStepState extends ConsumerState<IdentityStep> {
  late TextEditingController _nameCtrl;
  late TextEditingController _userCtrl;
  late TextEditingController _bioCtrl;

  @override
  void initState() {
    super.initState();
    final data = ref.read(createProfileDataProvider);
    _nameCtrl = TextEditingController(text: data.name);
    _userCtrl = TextEditingController(text: data.username);
    _bioCtrl = TextEditingController(text: data.bio);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _userCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(createProfileDataProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header
          Center(
            child: Text(
              "Create Your Profile",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: BluppiColors.textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "Let's get to know each other.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: BluppiColors.textSecondary,
                  ),
            ),
          ),
          const SizedBox(height: 32),

          // Avatar + Name/Username Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Class Widget
              AvatarPicker(profilePicPath: data.profilePicPath),

              const SizedBox(width: 20),

              // Name & Username (Right Side)
              Expanded(
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Display Name",
                      controller: _nameCtrl,
                      hint: "John Doe",
                      onChanged: (value) {
                        ref
                            .read(createProfileDataProvider.notifier)
                            .updateName(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Username",
                      controller: _userCtrl,
                      hint: "@johndoe",
                      icon: Icons.alternate_email,
                      onChanged: (value) {
                        ref
                            .read(createProfileDataProvider.notifier)
                            .updateUsername(value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Date of Birth & Gender Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date of Birth Class Widget
              Expanded(
                child: DateOfBirthPicker(
                  dateOfBirth: data.dateOfBirth,
                  age: data.dateOfBirth != null
                      ? DateTime.now().difference(data.dateOfBirth!).inDays ~/ 365
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Gender Selection Class Widget
              Expanded(
                child: GenderSelector(selectedGender: data.gender),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bio Field
          _buildTextField(
            label: "Bio",
            controller: _bioCtrl,
            hint: "Tell us a bit about yourself...",
            maxLines: 3,
            onChanged: (value) {
              ref.read(createProfileDataProvider.notifier).updateBio(value);
            },
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Utilities
  // ---------------------------------------------------------------------------

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    IconData? icon,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: BluppiColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: BluppiColors.surfaceRaised,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: BluppiColors.divider),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            style: const TextStyle(color: BluppiColors.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: BluppiColors.textDisabled),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              suffixIcon: icon != null
                  ? Icon(icon, color: BluppiColors.textDisabled)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}