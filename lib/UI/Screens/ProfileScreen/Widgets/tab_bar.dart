import 'package:bluppi/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarContents extends StatelessWidget {
  const TabBarContents({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // number of tabs
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TabBar(
            labelColor: AppColors.accent,
            indicatorColor: AppColors.accent,
            tabs: [
              Tab(text: "Blups"),
              Tab(text: "Playlists"),
              Tab(text: "Liked"),
            ],
          ),
          SizedBox(
            height: 300,
            child: const TabBarView(
              children: [
                Center(child: Text("Blups Feature Coming Soon")),
                Center(child: Text("Playlists Feature Coming Soon")),
                Center(child: Text("Liked Feature Coming Soon")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
