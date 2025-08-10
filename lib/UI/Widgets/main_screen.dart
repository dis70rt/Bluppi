import 'package:bluppi/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bluppi/Provider/MusicProvider/current_track_provider.dart';
import 'package:bluppi/Provider/RoomProvider/room_provider.dart';
import 'package:bluppi/UI/Screens/HomeScreen/Widgets/floating_music_player.dart';
import 'package:bluppi/UI/Screens/RoomScreen/utils/room_navigation.dart';
import 'package:bluppi/UI/Screens/SearchScreen/search_navigation_screen.dart';

import 'package:bluppi/UI/Screens/HomeScreen/home_screen.dart';
import 'package:bluppi/UI/Screens/ProfileScreen/profile_screen.dart';

final mainScreenIndexProvider = StateProvider<int>((ref) => 0);

class MainScreenWidget extends ConsumerWidget {
  const MainScreenWidget({super.key});

  final List<Widget?> _pages = const [
    HomeScreen(),
    RoomNavigationContainer(),
    SearchNavigationScreen(),
    // ChatsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mainScreenIndexProvider);
    final currentTrack = ref.watch(currentTrackProvider);
    final roomState = ref.watch(roomProvider);
    final isInRoomScreen = selectedIndex == 1;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: isInRoomScreen,
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
                bottom: 70,
                child: FloatingMusicPlayer(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: AppColors.backgroundDark,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavIcon(
              icon: FontAwesomeIcons.house,
              index: 0,
              selectedIndex: selectedIndex,
              onTap: () =>
                  ref.read(mainScreenIndexProvider.notifier).state = 0,
            ),
            NavIcon(
              icon: FontAwesomeIcons.wallet,
              index: 1,
              selectedIndex: selectedIndex,
              onTap: () =>
                  ref.read(mainScreenIndexProvider.notifier).state = 1,
            ),
            // const SizedBox(width: 48),
            NavIcon(
              icon: FontAwesomeIcons.magnifyingGlass,
              index: 2,
              selectedIndex: selectedIndex,
              onTap: () =>
                  ref.read(mainScreenIndexProvider.notifier).state = 2,
            ),
            NavIcon(
              icon: FontAwesomeIcons.user,
              index: 3,
              selectedIndex: selectedIndex,
              onTap: () =>
                  ref.read(mainScreenIndexProvider.notifier).state = 3,
            ),
          ],
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const NavIcon({
    super.key,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;
    return IconButton(
      onPressed: onTap,
      iconSize: 22,
      icon: FaIcon(icon),
      color: isSelected ? AppColors.textSecondary : AppColors.divider,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
