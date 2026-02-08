import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Skeletonizer(
        enabled: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bone.text(words: 2, style: TextStyle(fontSize: 24)),
              SizedBox(height: 16),
              Bone.text(words: 4, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}