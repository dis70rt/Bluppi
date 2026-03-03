import 'package:bluppi/data/grpc/repositories/room_service.dart';
import 'package:bluppi/domain/models/room_summary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListRoomState {
  final List<RoomSummaryModel> rooms;
  final bool isLoading;
  final String? errorMessage;
  final String nextPageToken;
  ListRoomState({
    required this.rooms,
    required this.isLoading,
    this.errorMessage,
    this.nextPageToken = '',
  });

  ListRoomState copyWith({
    List<RoomSummaryModel>? rooms,
    bool? isLoading,
    String? errorMessage,
    String? nextPageToken,
  }) {
    return ListRoomState(
      rooms: rooms ?? this.rooms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }
}

final listRoomsProvider = NotifierProvider<ListRoomNotifier, ListRoomState>(
  ListRoomNotifier.new,
);

class ListRoomNotifier extends Notifier<ListRoomState> {
  static const int _pageSize = 20;

  @override
  ListRoomState build() {
    state = ListRoomState(rooms: [], isLoading: false);
    _fetchFirstPage();
    
    return state;
  }

  Future<void> _fetchFirstPage() async {
    Future.microtask(() => state = state.copyWith(isLoading: true, errorMessage: null));

    try {
      final repo = ref.read(roomServiceProvider);
      final (rooms, nextToken) = await repo.listRooms(true, _pageSize, '');

      state = state.copyWith(
        rooms: rooms,
        nextPageToken: nextToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> fetchNextPage() async {
    if (state.isLoading || state.nextPageToken.isEmpty) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final repo = ref.read(roomServiceProvider);
      final (newRooms, nextToken) = await repo.listRooms(true, _pageSize, state.nextPageToken);

      state = state.copyWith(
        rooms: [...state.rooms, ...newRooms], 
        nextPageToken: nextToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    await _fetchFirstPage();
  }
}