// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:synqit/UI/Screens/HomeScreen/Widgets/floating_music_player.dart';

// class FloatingMusicPlayerManager {
//   static OverlayEntry? _overlayEntry;

//   static void show(BuildContext context, WidgetRef ref) {
//     if (_overlayEntry != null) return;

//     const bottomNavHeight = kBottomNavigationBarHeight + 8.0;

//     _overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: 0,
//         right: 0,
//         bottom: bottomNavHeight,
//         child: FloatingMusicPlayer(
//           onDispose: () {
//             hide();
//           },
//         ),
//       ),
//     );

//     // Overlay.of(context).insert(_overlayEntry!);
//     final overlay = Overlay.of(context);
//     final entries  = ModalRoute.of(context)?.overlayEntries;

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//         overlay.insert(_overlayEntry!, below: (entries != null && entries.isNotEmpty) ? entries.first : null);
//       });
//   }

//   static void hide() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
// }
