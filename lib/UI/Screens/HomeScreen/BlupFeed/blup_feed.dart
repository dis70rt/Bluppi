import 'package:bluppi/UI/Screens/HomeScreen/BlupFeed/widgets/testBlups.dart';
import 'package:flutter/material.dart';
import 'package:bluppi/UI/Screens/HomeScreen/BlupFeed/widgets/blup_card.dart';

class BlupFeed extends StatelessWidget {
  const BlupFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Friend's Blups",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),

          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: testBlups.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: BlupCard(blup: testBlups[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
