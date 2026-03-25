import 'package:bluppi/domain/models/activity_model.dart';

final List<ActivityModel> dummyActivities = [
  const ActivityModel(
    friendId: '1',
    friendName: 'Alice',
    friendAvatarUrl: 'https://i.pravatar.cc/150?u=1',
    status: 'online',
    trackTitle: 'Blinding Lights',
    trackArtist: 'The Weeknd',
  ),
  const ActivityModel(
    friendId: '2',
    friendName: 'Bob',
    friendAvatarUrl: 'https://i.pravatar.cc/150?u=2',
    status: 'offline',
    trackTitle: 'Shape of You',
    trackArtist: 'Ed Sheeran',
  ),
  const ActivityModel(
    friendId: '3',
    friendName: 'Charlie',
    friendAvatarUrl: 'https://i.pravatar.cc/150?u=3',
    status: 'online',
    trackTitle: 'Starboy',
    trackArtist: 'The Weeknd',
  ),
  const ActivityModel(
    friendId: '4',
    friendName: 'Diana',
    friendAvatarUrl: 'https://i.pravatar.cc/150?u=4',
    status: 'offline',
    // No track playing
  ),
];