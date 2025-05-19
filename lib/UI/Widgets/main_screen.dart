import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/floating_music_player.dart';
import 'package:synqit/UI/Screens/HomeScreen/Widgets/search_navigation_screen.dart';

import 'package:synqit/UI/Screens/HomeScreen/home_screen.dart';
import 'package:synqit/UI/Screens/ProfileScreen/profile_screen.dart';

final mainScreenIndexProvider = StateProvider<int>((ref) => 0);

class MainScreenWidget extends ConsumerWidget {
  const MainScreenWidget({super.key});

  final List<Widget> _pages = const [
    HomeScreen(),
    WalletPage(),
    SearchNavigationScreen(),
    MarketsPage(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mainScreenIndexProvider);

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
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
          
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.75],
              colors: [
              Colors.black.withValues(alpha: 0),
              Colors.black.withValues(alpha: 1),
            ]),
            
            
            // color: Colors.black,
            // border: Border(
            //   top: BorderSide(
            //     color: Colors.white.withValues(alpha: 0.1),
            //     width: 0.5,
            //   ),
            // ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const FloatingMusicPlayer(),
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
                    icon: FaIcon(FontAwesomeIcons.chartLine),
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

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton(
        onPressed: () {
          print("Logout button pressed - Implement actual sign out");
        },
        child: const Text("Logout", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ExchangePage extends StatelessWidget {
  const ExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Exchange Page", style: TextStyle(color: Colors.white)));
  }
}

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text("Markets Page", style: TextStyle(color: Colors.white)));
  }
}
