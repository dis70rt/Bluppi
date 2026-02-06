import 'package:bluppi/application/providers/create_profile_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/genre_widget.dart';
import 'package:bluppi/ui/screens/CreateProfileScreen/indentiy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateProfileScreen extends ConsumerWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(createProfileStepProvider);
    final totalSteps = 3;

    final steps = [const IdentityStep(), const GenreStep()];

    void onNext() {
      if (currentStep < totalSteps - 1) {
        ref.read(createProfileStepProvider.notifier).next();
      } else {
        // TODO: Call CreateUser API via gRPC
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Creating Profile...")));
      }
    }

    void onBack() {
      if (currentStep > 0) {
        ref.read(createProfileStepProvider.notifier).back();
      } else {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      backgroundColor: BluppiColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    color: BluppiColors.textSecondary,
                  ),
                  Text(
                    "${currentStep + 1} of $totalSteps",
                    style: const TextStyle(
                      color: BluppiColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: steps[currentStep],
              ),
            ),

            // Bottom Action Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BluppiColors.primary,
                    foregroundColor: BluppiColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentStep == totalSteps - 1 ? "Finish" : "Next →",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
