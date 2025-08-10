import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BlupFreqWidget extends StatelessWidget {
  final List<double> freqs;
  const BlupFreqWidget({super.key, required this.freqs});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.grey.shade900,
        padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: _generateBarGroups(freqs),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                ),
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child:
                    const Icon(Icons.play_arrow, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<double> frequencies) {
    return List.generate(frequencies.length, (index) {
      final double value = frequencies[index].clamp(0.0, 1.0);
      final double barHeight = (value * 45.0).clamp(3.0, 45.0);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: -barHeight,
            toY: barHeight,
            width: 2.5,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            gradient: LinearGradient(
              colors: [Colors.grey.shade300, Colors.white, Colors.grey.shade300],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }
}
