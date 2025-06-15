import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Provider/RoomProvider/room_service_provider.dart';

class JoinRoomDeepLinkScreen extends ConsumerStatefulWidget {
  final String roomCode;
  const JoinRoomDeepLinkScreen({super.key, required this.roomCode});

  @override
  ConsumerState<JoinRoomDeepLinkScreen> createState() => _JoinRoomDeepLinkScreenState();
}

class _JoinRoomDeepLinkScreenState extends ConsumerState<JoinRoomDeepLinkScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _joinRoomWithCode();
    });
  }

  Future<void> _joinRoomWithCode() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final roomNotifier = ref.read(roomProvider.notifier);
      
      // TODO: GetRoom by ROOM CODE implementation remains
      final joinedRoom = await roomNotifier.joinRoom(widget.roomCode, currentUserId);
      
      if (joinedRoom != null) {
        if (mounted) {
          // Navigation will happen through MainScreenWidget's listener
          // Just return to main screen and it will detect room state
          context.go('/main');
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Room not found or unable to join';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error joining room';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joining Room'),
        centerTitle: true,
      ),
      body: Center(
        child: _isLoading 
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Joining room...', style: TextStyle(color: Colors.white)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(_errorMessage ?? 'Unable to join room', 
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go('/main'),
                    child: const Text('Go to Home'),
                  )
                ],
              ),
      ),
    );
  }
}