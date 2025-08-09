import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Data/Services/user_services.dart';
import 'package:bluppi/Provider/UserProvider/user_provider.dart';
import 'package:bluppi/UI/Screens/ProfileScreen/profile_screen.dart';

class OtherProfileScreen extends ConsumerWidget {
  final String? username;
  final VoidCallback onBack;
  
  const OtherProfileScreen({
    super.key, 
    this.username,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (user) {
        return Scaffold(
      backgroundColor: const Color(0XFF181818),
      // appBar: user!.username != username ? AppBar(
      //   backgroundColor: AppColors.backgroundDark,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: onBack,
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.more_vert_rounded),
      //       onPressed: () => context.push('/settings'),
      //     ),
      //   ],
      //   title: username != null ?  Text(username!, style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),) : null,
      // ) : null,
      body: username == null 
        ? const Center(child: Text('No username provided'))
        : FutureBuilder(
            future: UserServices  ().getUserByUsername(username!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (snapshot.hasError || !snapshot.hasData) {
                return Center(child: Text('User not found: $username'));
              }
              
              final user = snapshot.data!;
              return ProfileScreen(user: user);
            },
          ),
    );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
    
  }
}