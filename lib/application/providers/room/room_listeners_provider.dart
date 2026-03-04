import 'dart:async';
import 'dart:developer';

import 'package:bluppi/application/providers/room/live_chat_provider.dart';
import 'package:bluppi/application/providers/user/user_provider.dart';
import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:bluppi/domain/models/room_events_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomEventState {
  final List<JoinedMemberModel> joinedMembers;
  final Map<String, JoinedMemberModel> members;
  final int totalMembers;

  RoomEventState({
    required this.joinedMembers,
    required this.members,
    required this.totalMembers,
  });

  RoomEventState copyWith({
    List<JoinedMemberModel>? joinedMembers,
    Map<String, JoinedMemberModel>? members,
    int? totalMembers,
  }) {
    return RoomEventState(
      joinedMembers: joinedMembers ?? this.joinedMembers,
      members: members ?? this.members,
      totalMembers: totalMembers ?? this.totalMembers,
    );
  }
}

final roomEventsProvider =
    NotifierProvider.family<RoomEventsNotifier, RoomEventState, String>(
      (arg) => RoomEventsNotifier(arg),
    );

class RoomEventsNotifier extends Notifier<RoomEventState> {
  final String roomId;
  RoomEventsNotifier(this.roomId);

  StreamSubscription<RoomEventModel>? _eventSub;

  @override
  RoomEventState build() {
    ref.onDispose(() {
      _eventSub?.cancel();
    });

    _initFetchMembers();
    _listenToEvents(roomId);
    return RoomEventState(
      joinedMembers: [],
      members: {},
      totalMembers: 0,
    );
  }

  Future<void> _initFetchMembers() async {
    final repo = ref.read(roomServiceProvider);
    final members = await repo.getRoomMembers(roomId);
    final membersMap = {for (var m in members) m.userId: m};

    state = state.copyWith(
      joinedMembers: members,
      members: membersMap,
      totalMembers: members.length,
    );
  }

  void _listenToEvents(String roomId) {
    final repo = ref.read(roomServiceProvider);
    final currentUserId = ref.read(userProvider).value?.id ?? '';

    _eventSub = repo.subscribeToRoomEvents(roomId, currentUserId).listen(
      (event) {
        switch (event.type) {
          case RoomEventType.userJoined:
          log('User Joined: ${event.joinedMember?.username}', name: 'RoomListenersNotifier');
          log('User ID: ${event.joinedMember?.userId}', name: 'RoomListenersNotifier');
          log('User Profile Pic: ${event.joinedMember?.avatarUrl}', name: 'RoomListenersNotifier');
          log('User Display Name: ${event.joinedMember?.displayName}', name: 'RoomListenersNotifier');
            addListener(event.joinedMember!);
            break;
          case RoomEventType.userLeft:
            removeListener(event.leftMember!.userId);
            break;
          case RoomEventType.roomEnded:
            log('Room Ended', name: 'RoomListenersNotifier');
            clear();
            break;
          case RoomEventType.liveChatMessage:
            final profile = state.members[event.liveChatMessage!.userId];
            ref.read(liveChatProvider(roomId).notifier).addUserMessage(
              msg: event.liveChatMessage!,
              profile: profile!,
            );
             break;
          case RoomEventType.unknown:
            break;
        }
      },
      onError: (err) {
        log('Listener Stream Error: $err', name: 'RoomListenersNotifier', error: err);
      },
    );
  }

  void addListener(JoinedMemberModel member) {
    final updatedMap = Map<String, JoinedMemberModel>.from(state.members);
    updatedMap[member.userId] = member;

    final updatedList = List<JoinedMemberModel>.from(state.joinedMembers)..add(member);
    state = state.copyWith(
      members: updatedMap,
      joinedMembers: updatedList,
      totalMembers: state.totalMembers + 1,
    );
  }

 void removeListener(String userId) {
    final updatedMap = Map<String, JoinedMemberModel>.from(state.members);
    updatedMap.remove(userId);

    final updatedList = state.joinedMembers.where((m) => m.userId != userId).toList();

    state = state.copyWith(
      members: updatedMap,
      joinedMembers: updatedList,
      totalMembers: updatedList.length,
    );
  }

  void clear() {
    state = RoomEventState(
      joinedMembers: [],
      members: {},
      totalMembers: 0,
    );
  }
}
