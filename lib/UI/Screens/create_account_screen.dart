import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/Utils/snackbar.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  final User firebaseUser;
  const CreateAccountScreen({super.key, required this.firebaseUser});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  bool _isLoading = false;
  String? _usernameError;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController =
        TextEditingController(text: widget.firebaseUser.displayName ?? '');
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }
    final trimmedValue = value.trim();
    if (trimmedValue.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (trimmedValue.length > 20) {
      return 'Username cannot exceed 20 characters';
    }

    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegExp.hasMatch(trimmedValue)) {
      return 'Only letters, numbers, and underscores allowed';
    }
    if (_usernameError != null) {
      return _usernameError;
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    return null;
  }

  String? _validateBio(String? value) {
    if (value != null && value.trim().length > 150) {
      return 'Bio cannot exceed 150 characters';
    }
    return null;
  }

  Future<bool> _isUsernameUnique(String username) async {
    try {
      final firestore = FirebaseFirestore.instance;

      final querySnapshot = await firestore
          .collection(usersCollection)
          .where('username_lowercase', isEqualTo: username.trim().toLowerCase())
          .limit(1)
          .get();
      return querySnapshot.docs.isEmpty;
    } catch (e) {
      log("Error checking username uniqueness: $e");

      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Error checking username. Please try again.',
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      }
      return false;
    }
  }

  Future<void> _createProfile() async {
    setState(() {
      _usernameError = null;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final isUnique = await _isUsernameUnique(username);

    if (!mounted) return;

    if (!isUnique) {
      setState(() {
        _usernameError = 'Username is already taken';
        _isLoading = false;
      });

      _formKey.currentState!.validate();
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;
      final userRef =
          firestore.collection(usersCollection).doc(widget.firebaseUser.uid);

      final newUser = UserModel(
        id: widget.firebaseUser.uid,
        username: username,
        name: _nameController.text.trim(),
        email: widget.firebaseUser.email ?? '',
        profilePic: widget.firebaseUser.photoURL,
        bio: _bioController.text.trim().isNotEmpty
            ? _bioController.text.trim()
            : null,
        createdAt: DateTime.now(),
        followers: 0,
        following: 0,
        phone: null,
        country: null,
        favoriteGenres: [],
      );

      await userRef.set(newUser.toFirestore());

      log("User profile created successfully for UID: ${widget.firebaseUser.uid}");

      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Profile created successfully!',
          icon: const Icon(Icons.check_circle, color: Colors.green),
        );
        
        context.pushReplacement('/main-screen');
      }
    } on FirebaseException catch (e) {
      log("Firestore Error creating profile: ${e.code} - ${e.message}");
      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Failed to create profile: ${e.message}',
          icon: const Icon(Icons.error, color: Colors.red),
        );
      }
    } catch (e) {
      log("Error creating profile: $e");
      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Failed to create profile. Please try again.',
          icon: const Icon(Icons.error, color: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.backgroundDark,
            ],
            stops: [0.2, 0.9],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildUsernameField(),
                    const SizedBox(height: 20),
                    _buildNameField(),
                    const SizedBox(height: 20),
                    _buildBioField(),
                    const SizedBox(height: 40),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.accent.withValues(alpha: 0.8),
                      AppColors.primary.withValues(alpha: 0.4),
                    ],
                  ),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.firebaseUser.photoURL != null
                      ? NetworkImage(widget.firebaseUser.photoURL!)
                      : null,
                  backgroundColor: AppColors.surfaceDark.withValues(alpha: 0.7),
                  child: widget.firebaseUser.photoURL == null
                      ? const Icon(Icons.person,
                          size: 50, color: AppColors.textPrimary)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Almost There!',
                style: TextStyle(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: AppColors.primary.withValues(alpha: 0.5),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Complete your profile to join the vibe.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(
          labelText: 'Username*',
          hintText: 'Choose a unique username',
          prefixIcon: Icons.alternate_email,
          errorText: _usernameError),
      validator: _validateUsername,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
      ],
      onChanged: (_) {
        if (_usernameError != null) {
          setState(() {
            _usernameError = null;
          });
        }
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(
        labelText: 'Display Name*',
        hintText: 'How you appear to others',
        prefixIcon: Icons.person_outline,
      ),
      validator: _validateName,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.words,
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      controller: _bioController,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(
        labelText: 'Bio (Optional)',
        hintText: 'Tell us about yourself (max 150 chars)',
        prefixIcon: Icons.edit_note_outlined,
      ),
      maxLines: 3,
      minLines: 1,
      maxLength: 150,
      validator: _validateBio,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget _buildSubmitButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _isLoading
                  ? [
                      AppColors.primaryAlt.withValues(alpha: 0.5),
                      AppColors.accent.withValues(alpha: 0.5),
                    ]
                  : [
                      AppColors.primaryAlt,
                      AppColors.accent,
                    ],
            ),
            border: Border.all(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: MaterialButton(
            onPressed: _isLoading ? null : _createProfile,
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            elevation: 0,
            highlightElevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Complete Profile',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    String? errorText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(
        color: AppColors.textPrimary.withValues(alpha: 0.8),
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.6)),
      prefixIcon: Icon(prefixIcon, color: AppColors.accent.withValues(alpha: 0.8)),
      filled: true,
      fillColor: AppColors.surface.withValues(alpha: 0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: AppColors.textPrimary.withValues(alpha: 0.1),
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: AppColors.textPrimary.withValues(alpha: 0.1),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: AppColors.accent.withValues(alpha: 0.8),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      errorStyle: const TextStyle(
        color: AppColors.error,
        fontWeight: FontWeight.w500,
      ),
      errorText: errorText,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
    );
  }
}
