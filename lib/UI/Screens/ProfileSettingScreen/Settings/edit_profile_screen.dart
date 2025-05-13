// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Constants/data.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/ProfileSettingScreen/Settings/username_dialog.dart';
import 'package:synqit/UI/Screens/ProfileSettingScreen/Widgets/edit_profile_widgets.dart';
import 'package:synqit/Utils/datetime.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _bioController;

  String? _selectedCountry;

  UserModel? _initialUserData;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _selectedCountry = countries[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _populateControllers(UserModel user) {
    if (_initialUserData == null || _initialUserData != user) {
      _nameController.text = user.name;
      _bioController.text = user.bio ?? '';

      if (user.country != null && countries.contains(user.country!)) {
        _selectedCountry = user.country;
      } else {
        _selectedCountry = countries[0];
      }

      _initialUserData = user;
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final countryToSave =
          (_selectedCountry != null && _selectedCountry != countries[0])
              ? _selectedCountry
              : null;

      final updatedUserData = _initialUserData?.copyWith(
        name: _nameController.text,
        bio: _bioController.text.isEmpty ? null : _bioController.text,
        country: countryToSave,
      );

      if (updatedUserData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Profile updated successfully!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.0),
            duration: Duration(seconds: 2),
          ),
        );
        ref.read(userProvider.notifier).update(updatedUserData.toFirestore());
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.redAccent),
                SizedBox(width: 8),
                Text('Error: No initial user data found.',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.0),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showChangeUsernameDialog(String currentUsername) async {
    final newUsername = await showDialog<String>(
      context: context,
      builder: (context) => ChangeUsernameDialog(
        currentUsername: currentUsername,
      ),
    );

    if (newUsername != null &&
        newUsername.isNotEmpty &&
        newUsername != currentUsername) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Text('Username changed to $newUsername!',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16.0),
          duration: const Duration(seconds: 3),
        ),
      );
    } else if (newUsername != null && newUsername.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.orangeAccent),
              SizedBox(width: 8),
              Text('Username cannot be empty.',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.0),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 0, 0),
                  Color.fromARGB(255, 25, 25, 25),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          userAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(
              child: Text('Error loading profile: $err',
                  style: const TextStyle(color: Colors.redAccent)),
            ),
            data: (user) {
              if (user == null) {
                return const Center(
                  child: Text(
                    'User profile not found.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              _populateControllers(user);

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 80),
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: user.profilePic != null &&
                                  user.profilePic!.isNotEmpty
                              ? NetworkImage(user.profilePic!)
                              : null,
                          child: user.profilePic == null ||
                                  user.profilePic!.isEmpty
                              ? const Icon(Icons.person,
                                  size: 60, color: Colors.white70)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Member Since:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatDate(user.createdAt),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      buildDisplayField(
                        label: 'Username',
                        value: user.username,
                        icon: Icons.edit,
                        onTap: () => _showChangeUsernameDialog(user.username),
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        controller: _nameController,
                        labelText: 'Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      buildTextField(
                        controller: _bioController,
                        labelText: 'Bio',
                        hintText: 'Tell us about yourself...',
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      buildDropdownField(
                        labelText: 'Country',
                        selectedValue: _selectedCountry,
                        items: countries,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCountry = newValue;
                          });
                        },
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          backgroundColor: AppColors.primaryAltDeep,
                          foregroundColor: AppColors.textPrimary,
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
