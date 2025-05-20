import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    required String message,
    required Widget icon}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    ),
  );
}
