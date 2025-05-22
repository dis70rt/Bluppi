import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/Provider/user_provider/user_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _pushNotifications = true;
  bool _darkMode = false;
  bool _faceId = false;

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/auth');
        });
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
        }

        return Scaffold(
          backgroundColor: const Color(0XFF181818),
          appBar: AppBar(
            
            title: const Text('Settings'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // centerTitle: true,
            // backgroundColor: Colors.black87,
            elevation: 0,
          ),
          body: Container(
            color: Theme.of(context).primaryColor,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                const _SettingsSectionTitle(title: 'ACCOUNT'),
                ListTile(
                  title: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading:
                      const Icon(Icons.person_outline, color: Colors.white),
                  onTap: () => context.push('/edit-profile'),
                ),
                ListTile(
                  title: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(Icons.lock_outline, color: Colors.white),
                  onTap: () {},
                ),
                const _SettingsSectionTitle(title: 'PREFERENCES'),
                SwitchListTile(
                  title: const Text(
                    'Push Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  secondary:
                      const Icon(Icons.notifications_none, color: Colors.white),
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  secondary:
                      const Icon(Icons.dark_mode_outlined, color: Colors.white),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text(
                    'Face ID',
                    style: TextStyle(color: Colors.white),
                  ),
                  secondary: const Icon(Icons.face, color: Colors.white),
                  value: _faceId,
                  onChanged: (value) {
                    setState(() {
                      _faceId = value;
                    });
                  },
                ),
                const _SettingsSectionTitle(title: 'PRIVACY & SECURITY'),
                ListTile(
                  title: const Text(
                    'Privacy Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(Icons.privacy_tip_outlined,
                      color: Colors.white),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Blocked Accounts',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading:
                      const Icon(Icons.block_outlined, color: Colors.white),
                  onTap: () {},
                ),
                const _SettingsSectionTitle(title: 'SUPPORT'),
                ListTile(
                  title: const Text(
                    'Help Center',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(Icons.help_outline, color: Colors.white),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text(
                    'Report a Problem',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading:
                      const Icon(Icons.report_outlined, color: Colors.white),
                  onTap: () {},
                ),
                const Divider(color: Colors.white54),
                ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  leading:
                      const Icon(Icons.exit_to_app, color: Colors.redAccent),
                  onTap: () async {
                    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging out...")
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

                    ref.read(authProvider.notifier).signOut();

                    if (context.mounted) {
        Navigator.of(context).pop(); 
        context.go('/auth'); 
      }
                  },
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _SettingsSectionTitle extends StatelessWidget {
  final String title;
  const _SettingsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
