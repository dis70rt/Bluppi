import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:synqit/Data/Models/track_model.dart';
import 'package:synqit/Data/Services/database_services.dart';
import 'package:synqit/Data/Services/user_services.dart';

import 'package:synqit/Provider/user_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/history_widget.dart';
import 'package:synqit/UI/Widgets/main_screen.dart';

final userServices = UserServices();
final database = Database();

Future<List<HistoryTrack>> getHistoryTracks() async {
  try {
    final historyEntries = await userServices.getHistoryTracks();
    if (historyEntries.isEmpty) {
      return [];
    }

    final List<Future<HistoryTrack?>> historyTrackFutures = historyEntries.map((historyEntry) {
      final trackId = historyEntry['trackId'];
      final playedAt = historyEntry['playedAt'];

      return Future<HistoryTrack?>(() async {
        final trackJson = await database.getTrack(trackId.toString());
        final track = Track.fromJson(trackJson['track']);
        // log("Tracks: $trackJson");
        return HistoryTrack(track: track, playedAt: playedAt);
      });
    }).toList();

    final List<HistoryTrack?> results = await Future.wait(historyTrackFutures);
    final List<HistoryTrack> validHistoryTracks = results.whereType<HistoryTrack>().toList();

    return validHistoryTracks;

    // final List<HistoryTrack?> historyTracks = [];
    // for(var historyEntry in historyEntries) {
    //   final trackId = historyEntry['trackId'];
    //   final playedAt = historyEntry['playedAt'];

    //   final _track = await database.getTrack(trackId);
    //   final track = Track.fromJson(_track);
    //   historyTracks.add(HistoryTrack(track: track, playedAt: playedAt));
    // }

    // return historyTracks;

  } catch (e, stackTrace) {
    log('Error fetching history tracks: $e');
    debugPrint('StackTrace: $stackTrace');
    return [];
  }
}

Widget iconButton(
    {required void Function() onPressed,
    required IconData icon,
    double size = 40.0,
    double iconSize = 20.0}) {
  return SizedBox(
    height: size,
    width: size,
    child: InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withValues(alpha: 0.2),
        ),
        child: Center(
          child: FaIcon(
            icon,
            size: iconSize,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

OverlayEntry? _currentOverlayEntry;
void showHistoryOverlay(BuildContext context, List<HistoryTrack> historyItems) {
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;
  
  _currentOverlayEntry = OverlayEntry(
    builder: (context) => HistoryOverlay(
      historyItems: historyItems,
      onDismiss: () {
        _currentOverlayEntry?.remove();
        _currentOverlayEntry = null;
      },
    ),
  );

  Overlay.of(context).insert(_currentOverlayEntry!);
}



PreferredSizeWidget homeAppBar(BuildContext context, WidgetRef ref) {
  final userAsync = ref.watch(userProvider);

  const double appBarHeight = 80.0;
  const Color appBarColor = Colors.black;
  const double avatarRadius = 22.0;
  const double horizontalPadding = 16.0;

  return PreferredSize(
    preferredSize: const Size.fromHeight(appBarHeight),
    child: userAsync.when(
      data: (user) {
        if (user == null) {
          return AppBar(
            toolbarHeight: appBarHeight,
            backgroundColor: appBarColor,
            title: const Text("Welcome!"),
          );
        }

        

        return AppBar(
          toolbarHeight: appBarHeight,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          titleSpacing: horizontalPadding,
          title: Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage:
                    user.profilePic != null && user.profilePic!.isNotEmpty
                        ? CachedNetworkImageProvider(user.profilePic!)
                        : const AssetImage('assets/images/default_profile.jpg')
                            as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome back,",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: iconButton(
                onPressed: () => ref.read(mainScreenIndexProvider.notifier).state = 2,
                icon: Icons.search,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: horizontalPadding - 4.0, left: 4.0),
              child: iconButton(
                onPressed: () async {
                  final historyTracks = await getHistoryTracks();
                  showHistoryOverlay(context, historyTracks);
                },
                icon: Icons.history,
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => AppBar(
        toolbarHeight: appBarHeight,
        backgroundColor: Colors.red.shade900,
        title: const Text("Error Loading User"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Retry",
            onPressed: () {
              ref.invalidate(userProvider);
            },
          ),
        ],
      ),
      loading: () => AppBar(
        toolbarHeight: appBarHeight,
        backgroundColor: appBarColor,
        automaticallyImplyLeading: false,
        titleSpacing: horizontalPadding,
        title: const Skeletonizer(
          enabled: true,
          child: Row(
            children: [
              CircleAvatar(radius: avatarRadius),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone.text(
                      words: 2,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 2),
                    Bone.text(
                      words: 1,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: iconButton(onPressed: () {}, icon: Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: horizontalPadding - 4.0, left: 4.0),
            child: iconButton(onPressed: () {}, icon: Icons.history),
          ),
        ],
      ),
    ),
  );
}
