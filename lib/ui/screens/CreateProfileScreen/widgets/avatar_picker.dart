import 'dart:io';
import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends ConsumerWidget {
  final String? profilePicPath;

  const AvatarPicker({
    super.key,
    required this.profilePicPath,
  });

  Future<void> _pickImage(WidgetRef ref, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 70, // Optimize for profile pictures
      maxWidth: 512,
      maxHeight: 512,
    );

    if (image != null) {
      ref.read(createProfileDataProvider.notifier).updateProfilePic(image.path);
    }
  }

  void _showImagePickerOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BluppiColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: BluppiColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Choose Photo",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: BluppiColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: BluppiColors.surfaceRaised,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: BluppiColors.primary),
                  ),
                  title: const Text(
                    "Take a Photo",
                    style: TextStyle(color: BluppiColors.textPrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ref, ImageSource.camera);
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: BluppiColors.surfaceRaised,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.photo_library,
                        color: BluppiColors.accent),
                  ),
                  title: const Text(
                    "Choose from Gallery",
                    style: TextStyle(color: BluppiColors.textPrimary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ref, ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showImagePickerOptions(context, ref),
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: BluppiColors.surfaceRaised,
              shape: BoxShape.circle,
              border: Border.all(color: BluppiColors.divider, width: 2),
              image: profilePicPath != null
                  ? DecorationImage(
                      image: FileImage(File(profilePicPath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profilePicPath == null
                ? const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: BluppiColors.textDisabled,
                    ),
                  )
                : null,
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
                border: Border.all(color: BluppiColors.background, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: BluppiColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}