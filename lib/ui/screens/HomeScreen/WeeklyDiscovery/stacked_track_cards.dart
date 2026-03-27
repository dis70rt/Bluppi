import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:bluppi/ui/screens/HomeScreen/WeeklyDiscovery/weekly_track_card.dart';

class StackedTrackCards extends StatefulWidget {
  final List<dynamic> tracks;

  const StackedTrackCards({super.key, required this.tracks});

  @override
  State<StackedTrackCards> createState() => _StackedTrackCardsState();
}

class _StackedTrackCardsState extends State<StackedTrackCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _autoScrollTimer;

  final double _cardHeight = 100.0;
  final double _peekOffset = 10.0;
  final double _scaleStep = 0.05;
  final int _visibleStackCount = 3;

  double _dragStartY = 0.0;
  double _dragStartValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this, value: 0.0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      double target = _controller.value.roundToDouble() + 1.0;
      if (target >= widget.tracks.length) {
        target = 0.0; // Loop back to start
      }
      
      final simulation = SpringSimulation(
        const SpringDescription(mass: 1, stiffness: 100, damping: 15),
        _controller.value,
        target,
        0,
      );
      _controller.animateWith(simulation);
    });
  }

  void _pauseAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    _pauseAutoScroll();
    _controller.stop();
    _dragStartY = details.globalPosition.dy;
    _dragStartValue = _controller.value;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double delta =
        (details.globalPosition.dy - _dragStartY) / (_cardHeight * 0.9);
    _controller.value = _dragStartValue + delta;
  }

  void _onPanEnd(DragEndDetails details) {
    final Velocity velocity = details.velocity;
    double target = _controller.value.roundToDouble();
    target = target.clamp(0.0, (widget.tracks.length - 1).toDouble());

    final simulation = SpringSimulation(
      const SpringDescription(mass: 1, stiffness: 150, damping: 18),
      _controller.value,
      target,
      velocity.pixelsPerSecond.dy / _cardHeight,
    );

    _controller.animateWith(simulation);
    _startAutoScroll(); // Resume auto scroll
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Reduced gap at the top and bottom
        final double totalHeight =
            _cardHeight + (_visibleStackCount * _peekOffset) + 20;

        return SizedBox(
          height: totalHeight,
          width: constraints.maxWidth,
          child: GestureDetector(
            onVerticalDragStart: _onPanStart,
            onVerticalDragUpdate: _onPanUpdate,
            onVerticalDragEnd: _onPanEnd,
            behavior: HitTestBehavior.translucent,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: _buildCards(constraints.maxWidth),
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCards(double maxWidth) {
    final List<_ZIndexedWidget> zIndexedWidgets = [];
    final double scrollValue = _controller.value;
    final int centerIndex = scrollValue.floor();

    for (int i = centerIndex - 1; i <= centerIndex + _visibleStackCount; i++) {
      if (i < 0 || i >= widget.tracks.length) continue;

      final double delta = i - scrollValue;
      if (delta < -1.5 || delta > _visibleStackCount) continue;

      double zIndex = delta < 0 ? 100.0 + delta * 10 : 100.0 - delta * 10;

      final isPrimaryCard = delta.abs() <= 0.3;

      zIndexedWidgets.add(
        _ZIndexedWidget(
          widget: _buildAnimatedCard(
            child: IgnorePointer(
              ignoring: !isPrimaryCard,
              child: WeeklyTrackCard(track: widget.tracks[i]),
            ),
            delta: delta,
            maxWidth: maxWidth,
          ),
          zIndex: zIndex,
        ),
      );
    }

    zIndexedWidgets.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return zIndexedWidgets.map((e) => e.widget).toList();
  }

  Widget _buildAnimatedCard({
    required Widget child,
    required double delta,
    required double maxWidth,
  }) {
    double yOffset = 0.0;
    double scale = 1.0;
    double opacity = 1.0;
    double rotation = 0.0;

    if (delta <= 0) {
      yOffset = -delta * (_cardHeight * 0.8);
      scale = 1.0;
      opacity = (1.0 + delta).clamp(0.0, 1.0);
      rotation = delta * 0.05;
    } else {
      yOffset = -(delta * _peekOffset);
      scale = 1.0 - (delta * _scaleStep);
      opacity = (_visibleStackCount - delta).clamp(0.0, 1.0);
    }

    return Positioned(
      top: 10 + (_visibleStackCount * _peekOffset) + yOffset, // Reduced from 20 to 10
      child: Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(rotation),
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: SizedBox(width: maxWidth, child: child),
          ),
        ),
      ),
    );
  }
}

class _ZIndexedWidget {
  final Widget widget;
  final double zIndex;
  _ZIndexedWidget({required this.widget, required this.zIndex});
}
