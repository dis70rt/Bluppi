import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synqit/Provider/auth_provider.dart';
import 'package:synqit/UI/Screens/HomeScreen/home_screen.dart';
import 'package:synqit/UI/Screens/ProfileScreen/profile_screen.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const WalletPage(),
    const ExchangePage(),
    const MarketsPage(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          // backgroundColor: Theme.of(context).primaryColor,
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
              icon: FaIcon(FontAwesomeIcons.rightLeft),
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          elevation: 0,
        ),
      ),
    );
  }
}

// Dummy pages (Replace with actual content)
class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: TextButton(onPressed: () => ref.read(authProvider.notifier).signOut(), child: Text("Logout"),));
  }
}

class ExchangePage extends StatelessWidget {
  const ExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Exchange Page"));
  }
}

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Markets Page"));
  }
}
