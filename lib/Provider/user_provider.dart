import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synqit/Data/Models/user_model.dart';
import 'package:synqit/Data/Services/user_services.dart';
import 'auth_provider.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
 
  final authUser = ref.watch(authProvider).value;
  final user = authUser?.user;
  if (authUser == null || user == null) return null;

  final spotify = SpotifyService(authUser.accessToken);
  Map<String, dynamic>? userData = await spotify.getUserProfile();
  if (userData == null) return null;

  return UserModel(
    id: user.id,
    name: user.userMetadata?['name'],
    email: user.email!,
    createdAt: DateTime.parse(user.createdAt),
    country: userData['country'],
    profilePic: (userData['images']?.isNotEmpty ?? false)
        ? userData['images'][0]['url']
        : null,
    phone: int.tryParse(user.userMetadata?['phone'] ?? ''),
  );
});
