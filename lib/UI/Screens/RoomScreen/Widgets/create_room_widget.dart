import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bluppi/Constants/colors.dart';
import 'package:bluppi/Provider/RoomProvider/room_service_provider.dart';

import '../../../../generated/protobuf/common.pbenum.dart';

class CreateRoomWidget extends ConsumerStatefulWidget {
  const CreateRoomWidget({super.key});

  @override
  ConsumerState<CreateRoomWidget> createState() => _CreateRoomWidgetState();
}

class _CreateRoomWidgetState extends ConsumerState<CreateRoomWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isExpanded = false;
  bool _isCreating = false;

  String _roomName = '';
  String _roomDescription = '';
  bool _isPublic = true;
  RoomVisibility _roomVisibility = RoomVisibility.PUBLIC;

  static const int _roomNameMaxLength = 25;
  static const int _descriptionMaxLength = 80;

  void _handleButtonPress() async {
    if (!mounted) return;
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
      });
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState!.save();
        await _createRoom();
      }
    }
  }

  Future<void> _createRoom() async {
    if (!mounted) return;
    setState(() {
      _isCreating = true;
    });

    try {
      final roomNotifier = ref.read(roomProvider.notifier);
      
      final String currentUserId = FirebaseAuth.instance.currentUser!.uid; 
      
      final createdRoom = await roomNotifier.createRoom(
        name: _roomName,
        description: _roomDescription,
        inviteOnly: !_isPublic, 
        visibility: _roomVisibility,
        hostUserId: currentUserId,
      );

      if (createdRoom != null && mounted) {
        if (mounted) {
          setState(() {
            _isExpanded = false;
            _isCreating = false;
          });
        }
        
        _formKey.currentState?.reset();
        _roomName = '';
        _roomDescription = '';
        _isPublic = true;
        _roomVisibility = RoomVisibility.PUBLIC;
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Room "${createdRoom.name}" created successfully!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _isCreating = false;
          });
        }
        
        final roomState = ref.read(roomProvider);
        if (roomState.errorMessage != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create room: ${roomState.errorMessage}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating room: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _closeForm() {
    if (!mounted) return;
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 300.0;
    final roomState = ref.watch(roomProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuart,
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: _isExpanded ? expandedHeight : 0.0,
            child: ClipRect(
              child: SingleChildScrollView(
                physics: _isExpanded
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Create Room',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: _isCreating ? null : _closeForm,
                                icon: const Icon(Icons.close, color: Colors.white),
                                iconSize: 24,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          
                          TextFormField(
                            enabled: !_isCreating,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Room Name*',
                              labelStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: AppColors.accent,
                                    width: 2.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 2.0),
                              ),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.05),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              errorStyle: TextStyle(
                                  color: AppColors.accent.withValues(alpha: 0.8)),
                              counterStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7)),
                            ),
                            maxLength: _roomNameMaxLength,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a room name';
                              }
                              return null;
                            },
                            onSaved: (value) => _roomName = value!,
                          ),
                          const SizedBox(height: 15),
                          
                          TextFormField(
                            enabled: !_isCreating,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Description (Optional)',
                              labelStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                    color: AppColors.accent,
                                    width: 2.0),
                              ),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.05),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              counterStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7)),
                            ),
                            maxLength: _descriptionMaxLength,
                            onSaved: (value) => _roomDescription = value ?? '',
                            maxLines: 2,
                            minLines: 1,
                          ),
                          const SizedBox(height: 15),
                          
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Room Visibility',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                AnimatedToggleSwitch<bool>.dual(
                                  current: _isPublic,
                                  first: false,
                                  second: true,
                                  spacing: 45.0,
                                  style: const ToggleStyle(
                                    borderColor: Colors.transparent,
                                    indicatorColor: Colors.white,
                                    backgroundColor: Colors.black26,
                                  ),
                                  customStyleBuilder: (context, local, global) => ToggleStyle(
                                    backgroundColor: AppColors.accent.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(25),
                                    indicatorColor: AppColors.accent,
                                  ),
                                  iconBuilder: (value) => value
                                      ? const Icon(Icons.public, color: Colors.white, size: 20)
                                      : const Icon(Icons.vpn_key, color: Colors.white, size: 20),
                                  textBuilder: (value) => Center(
                                    child: Text(
                                      value ? 'Public' : 'Private',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  onChanged: _isCreating ? null : (value) {
                                    if (mounted) {
                                      setState(() {
                                        _isPublic = value;
                                        _roomVisibility = value 
                                            ? RoomVisibility.PUBLIC 
                                            : RoomVisibility.PRIVATE;
                                      });
                                    }
                                  },
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_isCreating || roomState.isLoading) ? null : _handleButtonPress,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: _isCreating || (roomState.isLoading && _isExpanded)
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'CREATING...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    _isExpanded ? 'CREATE' : 'CREATE ROOM',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}