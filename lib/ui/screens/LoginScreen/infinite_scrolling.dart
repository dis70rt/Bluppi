import 'dart:math' as math;
import 'package:bluppi/application/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfiniteScrolling extends ConsumerStatefulWidget {
  const InfiniteScrolling({super.key});

  @override
  ConsumerState<InfiniteScrolling> createState() => _InfiniteScrollingState();
}

class _InfiniteScrollingState extends ConsumerState<InfiniteScrolling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Widget>? _cachedColumns;

  final List<double> cardHeights = [90.0, 100.0, 85.0, 95.0, 90.0, 105.0];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ref.read(imagesPreloadedProvider)) {
        ref.read(imagesPreloadedProvider.notifier).preloadImages(context);
      } else {
        _controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getTotalLoopHeight(int columnIndex, int totalItems) {
    const double cardMargin = 12.0;
    double total = 0;
    for (int i = 0; i < totalItems; i++) {
      final heightIndex = (i + columnIndex) % cardHeights.length;
      total += cardHeights[heightIndex] + cardMargin;
    }
    return total;
  }

  void _initializeColumns(List<String> avatars) {
    if (_cachedColumns != null && _cachedColumns!.isNotEmpty) return;
    if (avatars.isEmpty) return;

    _cachedColumns = [
      _buildScrollingColumn(0, avatars),
      const SizedBox(width: 12),
      _buildScrollingColumn(1, avatars, startOffset: 0.5),
      const SizedBox(width: 12),
      _buildScrollingColumn(2, avatars, startOffset: 0.2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLoaded = ref.watch(imagesPreloadedProvider);
    final avatars = ref.watch(scrollingImagesProvider);

    if (isLoaded && !_controller.isAnimating) {
      _controller.repeat();
    }

    if (!isLoaded || avatars.isEmpty) {
      return const SizedBox(height: 550, width: double.infinity);
    }

    _initializeColumns(avatars);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, opacity, child) {
        return Opacity(opacity: opacity, child: child);
      },
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [Colors.transparent, Colors.black],
            stops: [0.0, 0.4],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: SizedBox(
          height: 550,
          width: double.infinity,
          child: ClipRect(
            child: OverflowBox(
              maxHeight: double.infinity,
              maxWidth: double.infinity,
              child: Transform.rotate(
                angle: -15 * math.pi / 180,
                child: Transform.scale(
                  scale: 1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _cachedColumns ?? [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollingColumn(
    int columnIndex,
    List<String> avatars, {
    double startOffset = 0.0,
  }) {
    final loopHeight = _getTotalLoopHeight(columnIndex, avatars.length);

    final staticChildren = RepaintBoundary(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._buildCards(columnIndex, avatars, setIndex: 0),
          ..._buildCards(columnIndex, avatars, setIndex: 1),
          ..._buildCards(columnIndex, avatars, setIndex: 2),
        ],
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      child: staticChildren,
      builder: (context, child) {
        final currentScroll = (_controller.value + startOffset) % 1.0;
        final offset = currentScroll * loopHeight;

        return Transform.translate(offset: Offset(0, -offset), child: child);
      },
    );
  }

  List<Widget> _buildCards(
    int columnIndex,
    List<String> avatars, {
    required int setIndex,
  }) {
    return List.generate(avatars.length, (index) {
      final imageIndex = (index + columnIndex) % avatars.length;
      final heightIndex = (index + columnIndex) % cardHeights.length;
      final cardHeight = cardHeights[heightIndex];
      final url = avatars[imageIndex];

      final imageProvider = getOptimizedImageProvider(url);

      return Container(
        width: 90,
        height: cardHeight,
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(125),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Opacity(
          opacity: 0.8,
          child: Image(
            key: ValueKey('${url}_${columnIndex}_$setIndex'),
            image: imageProvider,
            width: 90,
            height: cardHeight,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            excludeFromSemantics: true,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[900],
              child: const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
        ),
      );
    });
  }
}
