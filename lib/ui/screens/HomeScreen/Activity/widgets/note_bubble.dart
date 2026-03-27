import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/constants.dart';
import 'package:bluppi/ui/screens/HomeScreen/Activity/widgets/track_content.dart';
import 'package:flutter/material.dart';

class _TailDot extends StatelessWidget {
  final double size;

  const _TailDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: NoteStyle.bubbleBg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(52),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class NoteBubble extends StatelessWidget {
  final String? trackTitle;
  final String? trackArtist;
  final String friendName;

  const NoteBubble({
    super.key,
    required this.trackTitle,
    required this.trackArtist,
    required this.friendName,
  });

  bool get _hasTrack => trackTitle != null && trackTitle!.trim().isNotEmpty;

  String get _placeholder {
    final index = friendName.length % NoteStyle.emptyPlaceholders.length;
    return NoteStyle.emptyPlaceholders[index];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Pill bubble
        Container(
          constraints: const BoxConstraints(maxWidth: 115, minWidth: 72),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: NoteStyle.bubbleBg,
            borderRadius: NoteStyle.bubbleRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(102),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _hasTrack
              ? TrackContent(trackTitle: trackTitle!, trackArtist: trackArtist)
              : PlaceholderContent(text: _placeholder),
        ),

        // Large tail dot
        const Positioned(bottom: -9, left: 12, child: _TailDot(size: 9)),

        // Small tail dot
        const Positioned(bottom: -16, left: 19, child: _TailDot(size: 5)),
      ],
    );
  }
}
