import 'package:bluppi/application/providers/auth/auth_provider.dart';
import 'package:bluppi/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => context.pop(),
          ),
          title: const Text('Settings'),
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _buildSectionHeader('Account'),
                  _buildSettingsTile(
                    context,
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {
                      // TODO: Navigate to Edit Profile
                    },
                  ),
                  _buildSettingsTile(
                    context,
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () {},
                  ),
      
                  const SizedBox(height: 16),
                  _buildSectionHeader('Privacy & Safety'),
                  _buildSettingsTile(
                    context,
                    icon: Icons.block,
                    title: 'Blocked Users',
                    onTap: () {},
                  ),
                  _buildSettingsTile(
                    context,
                    icon: Icons.visibility_off_outlined,
                    title: 'Muted Accounts',
                    onTap: () {},
                  ),
      
                  const SizedBox(height: 16),
                  _buildSectionHeader('Preferences'),
                  _buildSettingsTile(
                    context,
                    icon: Icons.notifications_none,
                    title: 'Push Notifications',
                    onTap: () {},
                  ),
                  _buildSettingsTile(
                    context,
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    onTap: () {},
                  ),
      
                  const SizedBox(height: 16),
                  _buildSectionHeader('About'),
                  _buildSettingsTile(
                    context,
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _buildSettingsTile(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () => _showLogoutDialog(context, ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BluppiColors.primary,
                        foregroundColor: BluppiColors.error,
                        side: const BorderSide(color: BluppiColors.error, width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: BluppiColors.textDisabled,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: BluppiColors.surfaceRaised,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: BluppiColors.primarySoft, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: BluppiColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                color: BluppiColors.textSecondary,
                fontSize: 13,
              ),
            )
          : null,
      trailing: const Icon(
        Icons.chevron_right,
        color: BluppiColors.textDisabled,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BluppiColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Log Out',
            style: TextStyle(color: BluppiColors.textPrimary),
          ),
          content: const Text(
            'Are you sure you want to log out of Bluppi?',
            style: TextStyle(color: BluppiColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: BluppiColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                context.pop();
                await ref.read(logoutProvider)();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: BluppiColors.error,
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }
}
