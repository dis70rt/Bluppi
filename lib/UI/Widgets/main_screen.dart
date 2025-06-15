import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:synqit/Constants/colors.dart';
import 'package:synqit/Provider/MusicProvider/current_track_provider.dart';
import 'package:synqit/Provider/RoomProvider/room_service_provider.dart';
import 'package:synqit/UI/Screens/ChatScreen/chats_screen.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/floating_music_player.dart';
import 'package:synqit/UI/Screens/RoomScreen/utils/room_navigation.dart';
import 'package:synqit/UI/Screens/SearchScreen/search_navigation_screen.dart';

import 'package:synqit/UI/Screens/HomeScreen/home_screen.dart';
import 'package:synqit/UI/Screens/ProfileScreen/profile_screen.dart';

final mainScreenIndexProvider = StateProvider<int>((ref) => 0);

class MainScreenWidget extends ConsumerWidget {
  const MainScreenWidget({super.key});

  final List<Widget?> _pages = const [
    HomeScreen(),
    RoomNavigationContainer(),
    SearchNavigationScreen(),
    ChatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mainScreenIndexProvider);
    final currentTrack = ref.watch(currentTrackProvider);
    final roomState = ref.watch(roomProvider);

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          IndexedStack(
            index: selectedIndex,
            children: _pages.map((page) => page ?? Container()).toList(),
          ),

          if (currentTrack != null)
          Visibility(
            visible: !roomState.isInRoom || selectedIndex != 1,
            child: Positioned(
              left: 0,
              right: 0,
              bottom:  70,
              child: FloatingMusicPlayer(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            canvasColor: Colors.transparent,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              elevation: 0,
            )),
        child: Container(
          
          color: AppColors.darkSurfaceBlack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                backgroundColor: Colors.transparent,
                iconSize: 22,
                items: const [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.wallet),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.comment),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.user),
                    label: '',
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white38,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  ref.read(mainScreenIndexProvider.notifier).state = index;
                },
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
