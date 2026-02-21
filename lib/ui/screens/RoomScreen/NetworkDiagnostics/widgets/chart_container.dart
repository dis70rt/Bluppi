import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget chart;
  final Color color;

  const ChartContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.chart,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C28),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(51)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Icon(Icons.monitor_heart, color: color.withAlpha(128), size: 14),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white.withAlpha(102), fontSize: 9),
          ),
          const SizedBox(height: 16),
          Expanded(child: chart),
        ],
      ),
    );
  }
}