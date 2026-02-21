import 'package:bluppi/application/providers/party/sync_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OffsetChart extends StatelessWidget {
  final List<ClockState> history;

  const OffsetChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    double minO = double.infinity;
    double maxO = double.negativeInfinity;
    for (var state in history) {
      double ms = state.thetaUs / 1000.0;
      if (ms < minO) minO = ms;
      if (ms > maxO) maxO = ms;
    }

    double spread = maxO - minO;
    if (spread < 5.0) spread = 5.0;
    double padding = spread * 0.2;

    double yInterval = spread / 4;
    if (yInterval <= 0) yInterval = 1.0;

    final spots = history.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.thetaUs / 1000);
    }).toList();

    return LineChart(
      LineChartData(
        minY: minO - padding,
        maxY: maxO + padding,
        minX: 0,
        maxX: 59,
        lineTouchData: const LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: yInterval,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.white.withAlpha(13), strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.white.withAlpha(5), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: yInterval,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                    color: Colors.white54, fontSize: 9, fontFamily: 'monospace'),
              ),
            ),
          ),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.cyanAccent,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.cyanAccent.withAlpha(13),
            ),
          ),
        ],
      ),
    );
  }
}

class SkewChart extends StatelessWidget {
  final List<ClockState> history;

  const SkewChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    double minA = double.infinity;
    double maxA = double.negativeInfinity;
    for (var state in history) {
      if (state.alpha < minA) minA = state.alpha;
      if (state.alpha > maxA) maxA = state.alpha;
    }

    double spread = maxA - minA;
    if (spread < 0.0001) spread = 0.0001;
    double padding = spread * 0.2;

    double yInterval = spread / 4;
    if (yInterval <= 0) yInterval = 0.00001;

    final spots = history.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value.alpha);
    }).toList();

    return LineChart(
      LineChartData(
        minY: minA - padding,
        maxY: maxA + padding,
        minX: 0,
        maxX: 59,
        lineTouchData: const LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: yInterval,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: Colors.white.withAlpha(13), strokeWidth: 1),
          getDrawingVerticalLine: (value) =>
              FlLine(color: Colors.white.withAlpha(5), strokeWidth: 1),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 55,
              interval: yInterval,
              getTitlesWidget: (value, meta) => Text(
                value.toStringAsFixed(5),
                style: const TextStyle(
                    color: Colors.white54, fontSize: 9, fontFamily: 'monospace'),
              ),
            ),
          ),
          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.pinkAccent,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.pinkAccent.withAlpha(13),
            ),
          ),
        ],
      ),
    );
  }
}