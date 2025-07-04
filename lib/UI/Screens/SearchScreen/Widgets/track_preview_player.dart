// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bluppi/Provider/MusicProvider/preview_provider.dart';

// class TrackPreviewPlayer extends ConsumerWidget {
//   final String? previewUrl;
//   final double size;

//   const TrackPreviewPlayer({
//     super.key,
//     required this.previewUrl,
//     this.size = 28.0,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final playerState = ref.watch(playerNotifierProvider);

//     final bool isCurrentTrack = previewUrl != null &&
//         previewUrl!.isNotEmpty &&
//         playerState.currentUrl == previewUrl;
//     final bool canPlay = previewUrl != null && previewUrl!.isNotEmpty;

//     Widget displayWidget;

//     if (!canPlay) {
//       displayWidget = Icon(
//         Icons.play_disabled_outlined,
//         color: Colors.white.withValues(alpha: 0.3),
//         size: size * 0.8,
//       );
//     } else if (isCurrentTrack &&
//         playerState.playbackState == AudioPlaybackState.loading) {
//       displayWidget = SizedBox(
//         width: size * 0.6,
//         height: size * 0.6,
//         child: CircularProgressIndicator(
//           strokeWidth: 2.0,
//           valueColor:
//               AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.8)),
//         ),
//       );
//     } else if (isCurrentTrack &&
//         playerState.playbackState == AudioPlaybackState.playing) {
//       displayWidget = Icon(
//         Icons.pause_circle_filled_rounded,
//         color: Colors.white.withValues(alpha: 0.9),
//         size: size,
//       );
//     } else {
//       displayWidget = Icon(
//         Icons.play_circle_filled_rounded,
//         color: Colors.white.withValues(alpha: 0.8),
//         size: size,
//       );
//     }

//     return InkWell(
//       borderRadius: BorderRadius.circular(size / 2),
//       onTap: canPlay
//           ? () {
//               final notifier = ref.read(playerNotifierProvider.notifier);
//               if (isCurrentTrack &&
//                   playerState.playbackState == AudioPlaybackState.playing) {
//                 notifier.pause();
//               } else {
//                 notifier.play(previewUrl!);
//               }
//             }
//           : null,
//       child: Container(
//         width: size + 4,
//         height: size + 4,
//         alignment: Alignment.center,
//         child: displayWidget,
//       ),
//     );
//   }
// }
