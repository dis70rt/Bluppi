import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

class PlaceholderContent extends StatelessWidget {
  final String text;

  const PlaceholderContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: NoteStyle.artistText,
        fontStyle: FontStyle.italic,
        height: 1.3,
      ),
    );
  }
}

class TrackContent extends StatelessWidget {
  final String trackTitle;
  final String? trackArtist;

  const TrackContent({
    super.key, 
    required this.trackTitle,
    this.trackArtist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ılı ',
              style: TextStyle(
                fontSize: 10,
                color: NoteStyle.musicBarColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            Flexible(
              child: TextScroll(
                trackTitle,
                mode: TextScrollMode.bouncing,
                velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                delayBefore: const Duration(milliseconds: 1500),
                pauseBetween: const Duration(milliseconds: 2500),
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: NoteStyle.bubbleText,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),

        if (trackArtist != null && trackArtist!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextScroll(
              trackArtist!,
              mode: TextScrollMode.bouncing,
              velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
              delayBefore: const Duration(milliseconds: 1500),
              pauseBetween: const Duration(milliseconds: 2500),
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: NoteStyle.artistText,
                letterSpacing: 0.1,
              ),
            ),
          ),
      ],
    );
  }
}