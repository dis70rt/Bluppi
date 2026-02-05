import 'dart:math';
import 'package:flutter/material.dart';

class SlideToSignInBtn extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onSlideComplete;
  final ThemeData theme;

  const SlideToSignInBtn({
    super.key,
    required this.isLoading,
    required this.onSlideComplete,
    required this.theme,
  });

  @override
  State<SlideToSignInBtn> createState() => _SlideToSignInBtnState();
}

class _SlideToSignInBtnState extends State<SlideToSignInBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  double _dragValue = 0.0;
  double _maxWidth = 0.0;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SlideToSignInBtn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoading && !widget.isLoading && _submitted) {
      setState(() {
        _submitted = false;
        _dragValue = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _maxWidth = constraints.maxWidth - 64;
        return Container(
          height: 64,
          decoration: BoxDecoration(
            color: widget.theme.colorScheme.secondary.withAlpha(255),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(50),
                        Colors.transparent,
                        Colors.black.withAlpha(50),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              Container(
                width: 64 + _dragValue,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.theme.colorScheme.surface.withAlpha(128),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),

              Center(
                child: Opacity(
                  opacity: max(0.0, 1.0 - (_dragValue / (_maxWidth * 0.5))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Slide to Sign In",
                          style: widget.theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5,

                            color: widget.theme.colorScheme.onSecondary,
                          ),
                        ),

                        const SizedBox(width: 8),
                        _buildAnimatedArrow(0),
                        _buildAnimatedArrow(1),
                        _buildAnimatedArrow(2),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: _dragValue + 4,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (widget.isLoading || _submitted) return;
                    setState(() {
                      _dragValue = (_dragValue + details.delta.dx).clamp(
                        0.0,
                        _maxWidth,
                      );
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    if (widget.isLoading || _submitted) return;

                    if (_dragValue >= _maxWidth * 0.9) {
                      setState(() {
                        _dragValue = _maxWidth;
                        _submitted = true;
                      });
                      widget.onSlideComplete();
                    } else {
                      setState(() {
                        _dragValue = 0.0;
                      });
                    }
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(40),
                          blurRadius: 4,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: widget.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.black,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/google.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedArrow(int index) {
    return AnimatedBuilder(
      animation: _arrowController,
      builder: (context, child) {
        double value = (_arrowController.value - (index * 0.2));

        if (value < 0) value += 1.0;

        double opacity = 0.3 + (sin(value * 2 * pi) * 0.5 + 0.5) * 0.7;

        return Icon(
          Icons.keyboard_arrow_right_rounded,
          size: 18,
          color: Colors.white.withAlpha((opacity * 255).toInt()),
        );
      },
    );
  }
}
