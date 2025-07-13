import 'dart:ui';

import 'package:flutter/material.dart';

void showPlaybackDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return allowPlaybackControl(context);
    },
  );
}

Widget allowPlaybackControl(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    child: Dialog(
      backgroundColor: Colors.grey.shade900.withValues(alpha: 0.8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side:
            BorderSide(color: Colors.grey.shade900, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "You're not the host",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "You can't play music here. Ask the host or leave to start your own session.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white.withValues(alpha: 0.3),
            //   ),
            //   child: const Text('OK'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // )
          ],
        ),
      ),
    ),
  );
}
