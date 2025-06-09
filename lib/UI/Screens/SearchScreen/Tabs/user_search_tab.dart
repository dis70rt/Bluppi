import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'package:synqit/Provider/user_provider/user_search_provider.dart';
import 'package:synqit/UI/Screens/SearchScreen/search_navigation_screen.dart';

class UsersSearchTab extends ConsumerWidget {
  final String query;
  final userServices = UserServices();
  
  UsersSearchTab({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSearchAsyncValue = ref.watch(userSearchProvider(query));
    final previousUserData = userSearchAsyncValue.valueOrNull;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: userSearchAsyncValue.when(
        loading: () {
          if (previousUserData != null &&
              previousUserData.users.isNotEmpty) {
            final users = previousUserData.users.where((user) {
              return user["id"] != userServices.auth.currentUser!.uid;
            }).toList();
      
            return Stack(
              children: [
                _buildUsersList(context, users, ref),
                Container(
                  height: 300,
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ],
            );
          }
      
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => _buildUserLoadingItem(),
          );
        },
        error: (error, _) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Error searching users: $error',
            style: const TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
        data: (usersResult) {
          if (usersResult.count == 0) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "No users found",
                style: TextStyle(color: Colors.white54),
                textAlign: TextAlign.center,
              ),
            );
          }
          
          final users = usersResult.users.where((user) {
            return user["id"] != userServices.auth.currentUser!.uid;
          }).toList();
          
          return _buildUsersList(context, users, ref);
        },
      ),
    );
  }

  Widget _buildUsersList(BuildContext context, List<dynamic> users, WidgetRef ref) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.primaries[index % Colors.primaries.length],
            child: user["profile_pic"] != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user["profile_pic"]!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 25,
                  ),
          ),
          title: Text(
            user["name"] ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "@${user["username"]}",
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => ref
              .read(searchNavigationProvider.notifier)
              .goToUserProfile(user["username"]),
        );
      },
    );
  }

  Widget _buildUserLoadingItem() {
    return Skeletonizer(
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade700.withValues(alpha: 0.5),
        ),
        title: Text(
          "Loading...",
          style: TextStyle(color: Colors.grey.shade700.withValues(alpha: 0.5)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          "Loading...",
          style: TextStyle(color: Colors.grey.shade700.withValues(alpha: 0.5)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}