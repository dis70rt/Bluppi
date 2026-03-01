import 'package:bluppi/application/providers/music/queue_provider.dart';
import 'package:bluppi/ui/widgets/floating_media_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouter.of(context).state.uri.path;
    final selectedIndex = _indexFromLocation(location);
    final queueState = ref.watch(queueProvider);
    final showFMP = queueState.currentTrack != null && location != '/rooms';
    // final roomState = ref.watch(roomProvider);
    // final isInRoomScreen = selectedIndex == 1;

    return Scaffold(
      extendBody: true,
      // resizeToAvoidBottomInset: isInRoomScreen,
      body: Stack(
        children: [
          child,
          if (showFMP)
          Positioned(
            left: 0,
            right: 0,
            bottom: 70,
            child: FloatingMusicPlayer())
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
          
          color: Theme.of(context).colorScheme.surface.withAlpha(200),
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
                    icon: FaIcon(FontAwesomeIcons.peopleGroup),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
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
                  context.go(_locationFromIndex(index));
                },
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith('/rooms')) return 1;
    if (location.startsWith('/search')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // home
  }

  String _locationFromIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/rooms';
      case 2:
        return '/search';
      case 3:
        return '/profile';
      default:
        return '/';
    }
  }
}
