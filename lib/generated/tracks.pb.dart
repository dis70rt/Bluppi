// This is a generated file - do not edit.
//
// Generated from tracks.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Track extends $pb.GeneratedMessage {
  factory Track({
    $core.String? id,
    $core.String? title,
    $core.String? artist,
    $core.int? durationMs,
    $core.Iterable<$core.String>? genres,
    $core.String? imageSmall,
    $core.String? imageLarge,
    $core.String? previewUrl,
    $core.String? videoId,
    $fixnum.Int64? listeners,
    $fixnum.Int64? playCount,
    $core.int? popularity,
    $1.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (durationMs != null) result.durationMs = durationMs;
    if (genres != null) result.genres.addAll(genres);
    if (imageSmall != null) result.imageSmall = imageSmall;
    if (imageLarge != null) result.imageLarge = imageLarge;
    if (previewUrl != null) result.previewUrl = previewUrl;
    if (videoId != null) result.videoId = videoId;
    if (listeners != null) result.listeners = listeners;
    if (playCount != null) result.playCount = playCount;
    if (popularity != null) result.popularity = popularity;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Track._();

  factory Track.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Track.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Track',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aI(5, _omitFieldNames ? '' : 'durationMs')
    ..pPS(6, _omitFieldNames ? '' : 'genres')
    ..aOS(7, _omitFieldNames ? '' : 'imageSmall')
    ..aOS(8, _omitFieldNames ? '' : 'imageLarge')
    ..aOS(9, _omitFieldNames ? '' : 'previewUrl')
    ..aOS(10, _omitFieldNames ? '' : 'videoId')
    ..aInt64(11, _omitFieldNames ? '' : 'listeners')
    ..aInt64(12, _omitFieldNames ? '' : 'playCount')
    ..aI(13, _omitFieldNames ? '' : 'popularity')
    ..aOM<$1.Timestamp>(14, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Track clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Track copyWith(void Function(Track) updates) =>
      super.copyWith((message) => updates(message as Track)) as Track;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Track create() => Track._();
  @$core.override
  Track createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Track getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Track>(create);
  static Track? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.int get durationMs => $_getIZ(3);
  @$pb.TagNumber(5)
  set durationMs($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(5)
  $core.bool hasDurationMs() => $_has(3);
  @$pb.TagNumber(5)
  void clearDurationMs() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get genres => $_getList(4);

  @$pb.TagNumber(7)
  $core.String get imageSmall => $_getSZ(5);
  @$pb.TagNumber(7)
  set imageSmall($core.String value) => $_setString(5, value);
  @$pb.TagNumber(7)
  $core.bool hasImageSmall() => $_has(5);
  @$pb.TagNumber(7)
  void clearImageSmall() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get imageLarge => $_getSZ(6);
  @$pb.TagNumber(8)
  set imageLarge($core.String value) => $_setString(6, value);
  @$pb.TagNumber(8)
  $core.bool hasImageLarge() => $_has(6);
  @$pb.TagNumber(8)
  void clearImageLarge() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get previewUrl => $_getSZ(7);
  @$pb.TagNumber(9)
  set previewUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(9)
  $core.bool hasPreviewUrl() => $_has(7);
  @$pb.TagNumber(9)
  void clearPreviewUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get videoId => $_getSZ(8);
  @$pb.TagNumber(10)
  set videoId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(10)
  $core.bool hasVideoId() => $_has(8);
  @$pb.TagNumber(10)
  void clearVideoId() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get listeners => $_getI64(9);
  @$pb.TagNumber(11)
  set listeners($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(11)
  $core.bool hasListeners() => $_has(9);
  @$pb.TagNumber(11)
  void clearListeners() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get playCount => $_getI64(10);
  @$pb.TagNumber(12)
  set playCount($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(12)
  $core.bool hasPlayCount() => $_has(10);
  @$pb.TagNumber(12)
  void clearPlayCount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get popularity => $_getIZ(11);
  @$pb.TagNumber(13)
  set popularity($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(13)
  $core.bool hasPopularity() => $_has(11);
  @$pb.TagNumber(13)
  void clearPopularity() => $_clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get createdAt => $_getN(12);
  @$pb.TagNumber(14)
  set createdAt($1.Timestamp value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureCreatedAt() => $_ensure(12);
}

class SearchTrack extends $pb.GeneratedMessage {
  factory SearchTrack({
    $core.String? id,
    $core.String? title,
    $core.String? artist,
    $core.String? imageSmall,
    $core.String? previewUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (imageSmall != null) result.imageSmall = imageSmall;
    if (previewUrl != null) result.previewUrl = previewUrl;
    return result;
  }

  SearchTrack._();

  factory SearchTrack.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTrack.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTrack',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(5, _omitFieldNames ? '' : 'imageSmall')
    ..aOS(6, _omitFieldNames ? '' : 'previewUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTrack clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTrack copyWith(void Function(SearchTrack) updates) =>
      super.copyWith((message) => updates(message as SearchTrack))
          as SearchTrack;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTrack create() => SearchTrack._();
  @$core.override
  SearchTrack createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchTrack getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTrack>(create);
  static SearchTrack? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.String get imageSmall => $_getSZ(3);
  @$pb.TagNumber(5)
  set imageSmall($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasImageSmall() => $_has(3);
  @$pb.TagNumber(5)
  void clearImageSmall() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get previewUrl => $_getSZ(4);
  @$pb.TagNumber(6)
  set previewUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(6)
  $core.bool hasPreviewUrl() => $_has(4);
  @$pb.TagNumber(6)
  void clearPreviewUrl() => $_clearField(6);
}

class TrackResponse extends $pb.GeneratedMessage {
  factory TrackResponse({
    Track? track,
  }) {
    final result = create();
    if (track != null) result.track = track;
    return result;
  }

  TrackResponse._();

  factory TrackResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOM<Track>(1, _omitFieldNames ? '' : 'track', subBuilder: Track.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackResponse copyWith(void Function(TrackResponse) updates) =>
      super.copyWith((message) => updates(message as TrackResponse))
          as TrackResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackResponse create() => TrackResponse._();
  @$core.override
  TrackResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackResponse>(create);
  static TrackResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Track get track => $_getN(0);
  @$pb.TagNumber(1)
  set track(Track value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrack() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrack() => $_clearField(1);
  @$pb.TagNumber(1)
  Track ensureTrack() => $_ensure(0);
}

class GetTrackRequest extends $pb.GeneratedMessage {
  factory GetTrackRequest({
    $core.String? trackId,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  GetTrackRequest._();

  factory GetTrackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackRequest copyWith(void Function(GetTrackRequest) updates) =>
      super.copyWith((message) => updates(message as GetTrackRequest))
          as GetTrackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackRequest create() => GetTrackRequest._();
  @$core.override
  GetTrackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackRequest>(create);
  static GetTrackRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);
}

class SearchTracksRequest extends $pb.GeneratedMessage {
  factory SearchTracksRequest({
    $core.String? query,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  SearchTracksRequest._();

  factory SearchTracksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTracksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTracksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aOS(3, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTracksRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTracksRequest copyWith(void Function(SearchTracksRequest) updates) =>
      super.copyWith((message) => updates(message as SearchTracksRequest))
          as SearchTracksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTracksRequest create() => SearchTracksRequest._();
  @$core.override
  SearchTracksRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchTracksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTracksRequest>(create);
  static SearchTracksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cursor => $_getSZ(2);
  @$pb.TagNumber(3)
  set cursor($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCursor() => $_has(2);
  @$pb.TagNumber(3)
  void clearCursor() => $_clearField(3);
}

class SearchTracksResponse extends $pb.GeneratedMessage {
  factory SearchTracksResponse({
    $core.Iterable<SearchTrack>? tracks,
    $core.String? query,
    $core.int? limit,
    $core.String? nextCursor,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (nextCursor != null) result.nextCursor = nextCursor;
    return result;
  }

  SearchTracksResponse._();

  factory SearchTracksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchTracksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchTracksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<SearchTrack>(1, _omitFieldNames ? '' : 'tracks',
        subBuilder: SearchTrack.create)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..aOS(4, _omitFieldNames ? '' : 'nextCursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTracksResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchTracksResponse copyWith(void Function(SearchTracksResponse) updates) =>
      super.copyWith((message) => updates(message as SearchTracksResponse))
          as SearchTracksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchTracksResponse create() => SearchTracksResponse._();
  @$core.override
  SearchTracksResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SearchTracksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchTracksResponse>(create);
  static SearchTracksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SearchTrack> get tracks => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get nextCursor => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextCursor($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextCursor() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextCursor() => $_clearField(4);
}

class GetPopularTracksRequest extends $pb.GeneratedMessage {
  factory GetPopularTracksRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetPopularTracksRequest._();

  factory GetPopularTracksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPopularTracksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPopularTracksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPopularTracksRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPopularTracksRequest copyWith(
          void Function(GetPopularTracksRequest) updates) =>
      super.copyWith((message) => updates(message as GetPopularTracksRequest))
          as GetPopularTracksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPopularTracksRequest create() => GetPopularTracksRequest._();
  @$core.override
  GetPopularTracksRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetPopularTracksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPopularTracksRequest>(create);
  static GetPopularTracksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class GetTracksByGenreRequest extends $pb.GeneratedMessage {
  factory GetTracksByGenreRequest({
    $core.String? genre,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (genre != null) result.genre = genre;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetTracksByGenreRequest._();

  factory GetTracksByGenreRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTracksByGenreRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTracksByGenreRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'genre')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTracksByGenreRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTracksByGenreRequest copyWith(
          void Function(GetTracksByGenreRequest) updates) =>
      super.copyWith((message) => updates(message as GetTracksByGenreRequest))
          as GetTracksByGenreRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTracksByGenreRequest create() => GetTracksByGenreRequest._();
  @$core.override
  GetTracksByGenreRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTracksByGenreRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTracksByGenreRequest>(create);
  static GetTracksByGenreRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get genre => $_getSZ(0);
  @$pb.TagNumber(1)
  set genre($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGenre() => $_has(0);
  @$pb.TagNumber(1)
  void clearGenre() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetTracksResponse extends $pb.GeneratedMessage {
  factory GetTracksResponse({
    $core.Iterable<Track>? tracks,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    if (total != null) result.total = total;
    return result;
  }

  GetTracksResponse._();

  factory GetTracksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTracksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTracksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<Track>(1, _omitFieldNames ? '' : 'tracks', subBuilder: Track.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTracksResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTracksResponse copyWith(void Function(GetTracksResponse) updates) =>
      super.copyWith((message) => updates(message as GetTracksResponse))
          as GetTracksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTracksResponse create() => GetTracksResponse._();
  @$core.override
  GetTracksResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTracksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTracksResponse>(create);
  static GetTracksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Track> get tracks => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class LikeTrackRequest extends $pb.GeneratedMessage {
  factory LikeTrackRequest({
    $core.String? trackId,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  LikeTrackRequest._();

  factory LikeTrackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LikeTrackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LikeTrackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LikeTrackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LikeTrackRequest copyWith(void Function(LikeTrackRequest) updates) =>
      super.copyWith((message) => updates(message as LikeTrackRequest))
          as LikeTrackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LikeTrackRequest create() => LikeTrackRequest._();
  @$core.override
  LikeTrackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LikeTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LikeTrackRequest>(create);
  static LikeTrackRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);
}

class UnlikeTrackRequest extends $pb.GeneratedMessage {
  factory UnlikeTrackRequest({
    $core.String? trackId,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  UnlikeTrackRequest._();

  factory UnlikeTrackRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlikeTrackRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlikeTrackRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlikeTrackRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlikeTrackRequest copyWith(void Function(UnlikeTrackRequest) updates) =>
      super.copyWith((message) => updates(message as UnlikeTrackRequest))
          as UnlikeTrackRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlikeTrackRequest create() => UnlikeTrackRequest._();
  @$core.override
  UnlikeTrackRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UnlikeTrackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlikeTrackRequest>(create);
  static UnlikeTrackRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);
}

class StatusResponse extends $pb.GeneratedMessage {
  factory StatusResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  StatusResponse._();

  factory StatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StatusResponse copyWith(void Function(StatusResponse) updates) =>
      super.copyWith((message) => updates(message as StatusResponse))
          as StatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StatusResponse create() => StatusResponse._();
  @$core.override
  StatusResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StatusResponse>(create);
  static StatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetLikedTracksRequest extends $pb.GeneratedMessage {
  factory GetLikedTracksRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetLikedTracksRequest._();

  factory GetLikedTracksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLikedTracksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLikedTracksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLikedTracksRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLikedTracksRequest copyWith(
          void Function(GetLikedTracksRequest) updates) =>
      super.copyWith((message) => updates(message as GetLikedTracksRequest))
          as GetLikedTracksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLikedTracksRequest create() => GetLikedTracksRequest._();
  @$core.override
  GetLikedTracksRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetLikedTracksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLikedTracksRequest>(create);
  static GetLikedTracksRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class LikedTrackEntry extends $pb.GeneratedMessage {
  factory LikedTrackEntry({
    $core.String? trackId,
    $core.String? title,
    $core.String? artist,
    $core.String? imageSmall,
    $1.Timestamp? likedAt,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (imageSmall != null) result.imageSmall = imageSmall;
    if (likedAt != null) result.likedAt = likedAt;
    return result;
  }

  LikedTrackEntry._();

  factory LikedTrackEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LikedTrackEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LikedTrackEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(5, _omitFieldNames ? '' : 'imageSmall')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'likedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LikedTrackEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LikedTrackEntry copyWith(void Function(LikedTrackEntry) updates) =>
      super.copyWith((message) => updates(message as LikedTrackEntry))
          as LikedTrackEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LikedTrackEntry create() => LikedTrackEntry._();
  @$core.override
  LikedTrackEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LikedTrackEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LikedTrackEntry>(create);
  static LikedTrackEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(5)
  $core.String get imageSmall => $_getSZ(3);
  @$pb.TagNumber(5)
  set imageSmall($core.String value) => $_setString(3, value);
  @$pb.TagNumber(5)
  $core.bool hasImageSmall() => $_has(3);
  @$pb.TagNumber(5)
  void clearImageSmall() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get likedAt => $_getN(4);
  @$pb.TagNumber(6)
  set likedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLikedAt() => $_has(4);
  @$pb.TagNumber(6)
  void clearLikedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLikedAt() => $_ensure(4);
}

class GetLikedTracksResponse extends $pb.GeneratedMessage {
  factory GetLikedTracksResponse({
    $core.Iterable<LikedTrackEntry>? tracks,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    if (total != null) result.total = total;
    return result;
  }

  GetLikedTracksResponse._();

  factory GetLikedTracksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLikedTracksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLikedTracksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<LikedTrackEntry>(1, _omitFieldNames ? '' : 'tracks',
        subBuilder: LikedTrackEntry.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLikedTracksResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLikedTracksResponse copyWith(
          void Function(GetLikedTracksResponse) updates) =>
      super.copyWith((message) => updates(message as GetLikedTracksResponse))
          as GetLikedTracksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLikedTracksResponse create() => GetLikedTracksResponse._();
  @$core.override
  GetLikedTracksResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetLikedTracksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLikedTracksResponse>(create);
  static GetLikedTracksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LikedTrackEntry> get tracks => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class IsTrackLikedRequest extends $pb.GeneratedMessage {
  factory IsTrackLikedRequest({
    $core.String? trackId,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  IsTrackLikedRequest._();

  factory IsTrackLikedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IsTrackLikedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IsTrackLikedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsTrackLikedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsTrackLikedRequest copyWith(void Function(IsTrackLikedRequest) updates) =>
      super.copyWith((message) => updates(message as IsTrackLikedRequest))
          as IsTrackLikedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IsTrackLikedRequest create() => IsTrackLikedRequest._();
  @$core.override
  IsTrackLikedRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IsTrackLikedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IsTrackLikedRequest>(create);
  static IsTrackLikedRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);
}

class IsTrackLikedResponse extends $pb.GeneratedMessage {
  factory IsTrackLikedResponse({
    $core.bool? isLiked,
  }) {
    final result = create();
    if (isLiked != null) result.isLiked = isLiked;
    return result;
  }

  IsTrackLikedResponse._();

  factory IsTrackLikedResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IsTrackLikedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IsTrackLikedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isLiked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsTrackLikedResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IsTrackLikedResponse copyWith(void Function(IsTrackLikedResponse) updates) =>
      super.copyWith((message) => updates(message as IsTrackLikedResponse))
          as IsTrackLikedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IsTrackLikedResponse create() => IsTrackLikedResponse._();
  @$core.override
  IsTrackLikedResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static IsTrackLikedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IsTrackLikedResponse>(create);
  static IsTrackLikedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isLiked => $_getBF(0);
  @$pb.TagNumber(1)
  set isLiked($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsLiked() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsLiked() => $_clearField(1);
}

class AddTrackToHistoryRequest extends $pb.GeneratedMessage {
  factory AddTrackToHistoryRequest({
    $core.String? trackId,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    return result;
  }

  AddTrackToHistoryRequest._();

  factory AddTrackToHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddTrackToHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddTrackToHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'trackId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTrackToHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddTrackToHistoryRequest copyWith(
          void Function(AddTrackToHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as AddTrackToHistoryRequest))
          as AddTrackToHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddTrackToHistoryRequest create() => AddTrackToHistoryRequest._();
  @$core.override
  AddTrackToHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddTrackToHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddTrackToHistoryRequest>(create);
  static AddTrackToHistoryRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(2)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(2)
  void clearTrackId() => $_clearField(2);
}

class GetTrackHistoryRequest extends $pb.GeneratedMessage {
  factory GetTrackHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetTrackHistoryRequest._();

  factory GetTrackHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..aI(3, _omitFieldNames ? '' : 'offset')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackHistoryRequest copyWith(
          void Function(GetTrackHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetTrackHistoryRequest))
          as GetTrackHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackHistoryRequest create() => GetTrackHistoryRequest._();
  @$core.override
  GetTrackHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTrackHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackHistoryRequest>(create);
  static GetTrackHistoryRequest? _defaultInstance;

  /// string user_id = 1;
  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class HistoryTrackEntry extends $pb.GeneratedMessage {
  factory HistoryTrackEntry({
    $core.String? trackId,
    $core.String? title,
    $core.String? artist,
    $core.String? imageLarge,
    $core.String? imageSmall,
    $1.Timestamp? playedAt,
  }) {
    final result = create();
    if (trackId != null) result.trackId = trackId;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (imageLarge != null) result.imageLarge = imageLarge;
    if (imageSmall != null) result.imageSmall = imageSmall;
    if (playedAt != null) result.playedAt = playedAt;
    return result;
  }

  HistoryTrackEntry._();

  factory HistoryTrackEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HistoryTrackEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HistoryTrackEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(4, _omitFieldNames ? '' : 'imageLarge')
    ..aOS(5, _omitFieldNames ? '' : 'imageSmall')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'playedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryTrackEntry clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryTrackEntry copyWith(void Function(HistoryTrackEntry) updates) =>
      super.copyWith((message) => updates(message as HistoryTrackEntry))
          as HistoryTrackEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HistoryTrackEntry create() => HistoryTrackEntry._();
  @$core.override
  HistoryTrackEntry createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HistoryTrackEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HistoryTrackEntry>(create);
  static HistoryTrackEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get trackId => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageLarge => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageLarge($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageLarge() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageLarge() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageSmall => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageSmall($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasImageSmall() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageSmall() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get playedAt => $_getN(5);
  @$pb.TagNumber(6)
  set playedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPlayedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearPlayedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensurePlayedAt() => $_ensure(5);
}

class GetTrackHistoryResponse extends $pb.GeneratedMessage {
  factory GetTrackHistoryResponse({
    $core.Iterable<HistoryTrackEntry>? history,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (history != null) result.history.addAll(history);
    if (total != null) result.total = total;
    return result;
  }

  GetTrackHistoryResponse._();

  factory GetTrackHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrackHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrackHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<HistoryTrackEntry>(1, _omitFieldNames ? '' : 'history',
        subBuilder: HistoryTrackEntry.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrackHistoryResponse copyWith(
          void Function(GetTrackHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetTrackHistoryResponse))
          as GetTrackHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrackHistoryResponse create() => GetTrackHistoryResponse._();
  @$core.override
  GetTrackHistoryResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTrackHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrackHistoryResponse>(create);
  static GetTrackHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HistoryTrackEntry> get history => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class ClearTrackHistoryRequest extends $pb.GeneratedMessage {
  factory ClearTrackHistoryRequest() => create();

  ClearTrackHistoryRequest._();

  factory ClearTrackHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ClearTrackHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClearTrackHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearTrackHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearTrackHistoryRequest copyWith(
          void Function(ClearTrackHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as ClearTrackHistoryRequest))
          as ClearTrackHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClearTrackHistoryRequest create() => ClearTrackHistoryRequest._();
  @$core.override
  ClearTrackHistoryRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ClearTrackHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClearTrackHistoryRequest>(create);
  static ClearTrackHistoryRequest? _defaultInstance;
}

class GetRecommendationsRequest extends $pb.GeneratedMessage {
  factory GetRecommendationsRequest({
    $core.String? videoId,
    $core.int? limit,
  }) {
    final result = create();
    if (videoId != null) result.videoId = videoId;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetRecommendationsRequest._();

  factory GetRecommendationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecommendationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecommendationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendationsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendationsRequest copyWith(
          void Function(GetRecommendationsRequest) updates) =>
      super.copyWith((message) => updates(message as GetRecommendationsRequest))
          as GetRecommendationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecommendationsRequest create() => GetRecommendationsRequest._();
  @$core.override
  GetRecommendationsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecommendationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecommendationsRequest>(create);
  static GetRecommendationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetRecommendationsResponse extends $pb.GeneratedMessage {
  factory GetRecommendationsResponse({
    $core.Iterable<Track>? tracks,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    return result;
  }

  GetRecommendationsResponse._();

  factory GetRecommendationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRecommendationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRecommendationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<Track>(1, _omitFieldNames ? '' : 'tracks', subBuilder: Track.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendationsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRecommendationsResponse copyWith(
          void Function(GetRecommendationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetRecommendationsResponse))
          as GetRecommendationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecommendationsResponse create() => GetRecommendationsResponse._();
  @$core.override
  GetRecommendationsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetRecommendationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRecommendationsResponse>(create);
  static GetRecommendationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Track> get tracks => $_getList(0);
}

class TrackSummary extends $pb.GeneratedMessage {
  factory TrackSummary({
    $core.String? id,
    $core.String? title,
    $core.String? artist,
    $core.String? imageUrl,
    $core.String? previewUrl,
    $core.int? socialCount,
    $core.String? socialContext,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (artist != null) result.artist = artist;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (previewUrl != null) result.previewUrl = previewUrl;
    if (socialCount != null) result.socialCount = socialCount;
    if (socialContext != null) result.socialContext = socialContext;
    return result;
  }

  TrackSummary._();

  factory TrackSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TrackSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrackSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'artist')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'previewUrl')
    ..aI(6, _omitFieldNames ? '' : 'socialCount')
    ..aOS(7, _omitFieldNames ? '' : 'socialContext')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackSummary clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrackSummary copyWith(void Function(TrackSummary) updates) =>
      super.copyWith((message) => updates(message as TrackSummary))
          as TrackSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackSummary create() => TrackSummary._();
  @$core.override
  TrackSummary createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TrackSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrackSummary>(create);
  static TrackSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get artist => $_getSZ(2);
  @$pb.TagNumber(3)
  set artist($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArtist() => $_has(2);
  @$pb.TagNumber(3)
  void clearArtist() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get previewUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set previewUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPreviewUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreviewUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get socialCount => $_getIZ(5);
  @$pb.TagNumber(6)
  set socialCount($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSocialCount() => $_has(5);
  @$pb.TagNumber(6)
  void clearSocialCount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get socialContext => $_getSZ(6);
  @$pb.TagNumber(7)
  set socialContext($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSocialContext() => $_has(6);
  @$pb.TagNumber(7)
  void clearSocialContext() => $_clearField(7);
}

class DiscoverTracksRequest extends $pb.GeneratedMessage {
  factory DiscoverTracksRequest({
    $core.int? limit,
    $core.String? nextCursor,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (nextCursor != null) result.nextCursor = nextCursor;
    return result;
  }

  DiscoverTracksRequest._();

  factory DiscoverTracksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiscoverTracksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiscoverTracksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'limit')
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscoverTracksRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscoverTracksRequest copyWith(
          void Function(DiscoverTracksRequest) updates) =>
      super.copyWith((message) => updates(message as DiscoverTracksRequest))
          as DiscoverTracksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscoverTracksRequest create() => DiscoverTracksRequest._();
  @$core.override
  DiscoverTracksRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DiscoverTracksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiscoverTracksRequest>(create);
  static DiscoverTracksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);
}

class DiscoverTracksResponse extends $pb.GeneratedMessage {
  factory DiscoverTracksResponse({
    $core.Iterable<TrackSummary>? tracks,
    $core.String? nextCursor,
    $core.bool? hasMore,
  }) {
    final result = create();
    if (tracks != null) result.tracks.addAll(tracks);
    if (nextCursor != null) result.nextCursor = nextCursor;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  DiscoverTracksResponse._();

  factory DiscoverTracksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DiscoverTracksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DiscoverTracksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'tracks'),
      createEmptyInstance: create)
    ..pPM<TrackSummary>(1, _omitFieldNames ? '' : 'tracks',
        subBuilder: TrackSummary.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..aOB(3, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscoverTracksResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DiscoverTracksResponse copyWith(
          void Function(DiscoverTracksResponse) updates) =>
      super.copyWith((message) => updates(message as DiscoverTracksResponse))
          as DiscoverTracksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DiscoverTracksResponse create() => DiscoverTracksResponse._();
  @$core.override
  DiscoverTracksResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DiscoverTracksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DiscoverTracksResponse>(create);
  static DiscoverTracksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TrackSummary> get tracks => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get hasMore => $_getBF(2);
  @$pb.TagNumber(3)
  set hasMore($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHasMore() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasMore() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
