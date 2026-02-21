import 'package:flutter/material.dart';

class MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final String description;

  const MiniStat({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withAlpha(128),
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 2),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final messenger = ScaffoldMessenger.of(context);

                messenger.hideCurrentSnackBar();

                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      description,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF2A2A3D),
                    elevation: 10,
                    margin: const EdgeInsets.only(
                      bottom: 30,
                      left: 20,
                      right: 20,
                    ),
                    duration: const Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  Icons.info_outline,
                  color: Colors.white.withAlpha(100),
                  size: 14,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 0),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}
