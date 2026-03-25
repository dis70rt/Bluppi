import 'package:bluppi/generated/friends_activity.pb.dart' as proto;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';

class ActivityModel {
  final String friendId;
  final String friendName;
  final String friendAvatarUrl;
  final String status;
  final String? trackId;
  final String? trackTitle;
  final String? trackArtist;
  final String? trackCoverUrl;
  final String? previewUrl;
  final DateTime? lastSeen;

  const ActivityModel({
    required this.friendId,
    required this.friendName,
    required this.friendAvatarUrl,
    required this.status,
    this.trackId,
    this.trackTitle,
    this.trackArtist,
    this.trackCoverUrl,
    this.previewUrl,
    this.lastSeen,
  });

  ActivityModel copyWith({
    String? friendId,
    String? friendName,
    String? friendAvatarUrl,
    String? status,
    String? trackId,
    String? trackTitle,
    String? trackArtist,
    String? trackCoverUrl,
    String? previewUrl,
    DateTime? lastSeen,
  }) {
    return ActivityModel(
      friendId: friendId ?? this.friendId,
      friendName: friendName ?? this.friendName,
      friendAvatarUrl: friendAvatarUrl ?? this.friendAvatarUrl,
      status: status ?? this.status,
      trackId: trackId ?? this.trackId,
      trackTitle: trackTitle ?? this.trackTitle,
      trackArtist: trackArtist ?? this.trackArtist,
      trackCoverUrl: trackCoverUrl ?? this.trackCoverUrl,
      previewUrl: previewUrl ?? this.previewUrl,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  factory ActivityModel.fromProto(proto.FriendActivity protoActivity) {
    return ActivityModel(
      friendId: protoActivity.friendId,
      friendName: protoActivity.friendName,
      friendAvatarUrl: protoActivity.friendAvatarUrl,
      status: protoActivity.status,
      trackId: protoActivity.hasTrackId() ? protoActivity.trackId : null,
      trackTitle: protoActivity.hasTrackTitle() ? protoActivity.trackTitle : null,
      trackArtist: protoActivity.hasTrackArtist() ? protoActivity.trackArtist : null,
      trackCoverUrl: protoActivity.hasTrackCoverUrl() ? protoActivity.trackCoverUrl : null,
      previewUrl: protoActivity.hasTrackPreviewUrl() ? protoActivity.trackPreviewUrl : null,
      lastSeen: protoActivity.hasLastSeen() ? protoActivity.lastSeen.toDateTime() : null,
    );
  }

  proto.FriendActivity toProto() {
    return proto.FriendActivity(
      friendId: friendId,
      friendName: friendName,
      friendAvatarUrl: friendAvatarUrl,
      status: status,
      trackId: trackId,
      trackTitle: trackTitle,
      trackArtist: trackArtist,
      trackCoverUrl: trackCoverUrl,
      trackPreviewUrl: previewUrl,
      lastSeen: lastSeen != null ? Timestamp.fromDateTime(lastSeen!) : null,
    );
  }
}