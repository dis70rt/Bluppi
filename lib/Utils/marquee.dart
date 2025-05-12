// Utils/marquee.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Required for TickerProviderStateMixin

// Custom widget for horizontal marquee text
class Marquee extends StatefulWidget {
  const Marquee({
    Key? key,
    required this.text,
    this.style,
    this.scrollSpeed = 30.0, // Pixels per second
    this.blankSpace = 20.0,  // Space between repeats
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final double scrollSpeed;
  final double blankSpace;

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _textWidth = 0.0;
  double _textHeight = 0.0; // Added to store calculated text height
  double _containerWidth = 0.0;
  bool _needsScrolling = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Initial placeholder duration
    );

    // Calculate sizes after the first frame is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _calculateSizes();
    });
  }

  @override
  void didUpdateWidget(covariant Marquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.style != widget.style || oldWidget.scrollSpeed != widget.scrollSpeed || oldWidget.blankSpace != oldWidget.blankSpace) {
      _controller.stop(); // Stop old animation
      // Recalculate sizes and restart animation based on new text/style
       SchedulerBinding.instance.addPostFrameCallback((_) {
          _calculateSizes(); // This will recalculate dimensions and restart animation
       });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Calculates the intrinsic width and height of the text
  void _calculateTextDimensions() {
     // Use the provided style or the default text style from context
    final style = widget.style ?? DefaultTextStyle.of(context).style;
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: style),
      textDirection: Directionality.of(context), // Use direction from context
      maxLines: 1, // Measure as a single line
    )..layout();
    _textWidth = textPainter.width;
    _textHeight = textPainter.height; // Store the calculated height
  }

  // Starts or updates the animation based on calculated sizes
  void _startAnimation() {
     // Only start/update if we have both text and container widths calculated
    if (_textWidth > 0 && _containerWidth > 0) {
        _needsScrolling = _textWidth > _containerWidth;

        if (_needsScrolling) {
            // Calculate the total distance to scroll (text width + blank space)
            // The animation value will go from 0 to 1, and we'll multiply it
            // by the negative scroll distance to get the offset.
            final scrollDistance = _textWidth + widget.blankSpace; // Scroll full text width + blank space

            // Calculate duration based on speed and distance
            final duration = Duration(milliseconds: (scrollDistance / widget.scrollSpeed * 1000).round());

            // Update controller duration if it's different
            if (_controller.duration != duration) {
               _controller.duration = duration;
            }

            // Start the animation repeating from 0.0 to 1.0
            if (!_controller.isAnimating) {
               // Reset value to start from the beginning of the scroll
               _controller.value = 0.0;
               _controller.repeat();
            }
        } else {
            // Text fits, stop animation and reset position
            _controller.stop();
            _controller.value = 0.0; // Reset to the beginning
            _needsScrolling = false;
        }
    } else {
        // Sizes not yet available, stop any running animation
        _controller.stop();
        _controller.value = 0.0;
        _needsScrolling = false;
    }
  }

   // Recalculates dimensions and starts/updates the animation
   void _calculateSizes() {
     _calculateTextDimensions(); // Get text width and height first
     // _containerWidth is updated by LayoutBuilder in the build method before this is called
     _startAnimation(); // Start/update animation based on new sizes
     // We need to call setState to trigger a rebuild now that _textHeight is known
     // Use addPostFrameCallback to avoid calling setState during layout phase
      if (mounted) { // Check if the widget is still in the tree
        setState(() {}); // Trigger rebuild after dimensions are known
      }
   }


  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to get the maximum width constraint available for this widget
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update container width if it changes significantly
        if (constraints.maxWidth != _containerWidth) {
           _containerWidth = constraints.maxWidth;
           // Recalculate and restart animation based on the new width
           // Use post frame callback to avoid setting state during build
           SchedulerBinding.instance.addPostFrameCallback((_) {
               _calculateSizes(); // Schedules calculation and animation start
           });
        }

        // We need the height calculated before we can constrain the widget
        // Return an empty container or a placeholder until dimensions are known
        if (_textHeight <= 0) {
            // Return a placeholder with the determined width but minimum height
             return SizedBox(
                 width: _containerWidth > 0 ? _containerWidth : null,
                 height: 0, // Or a small placeholder height
             );
        }

        // Wrap the entire content in a SizedBox with the calculated text height
        return SizedBox(
           height: _textHeight, // **Constrain the height here**
           width: _containerWidth > 0 ? _containerWidth : null, // Use container width if known, else let parent determine
           child: _needsScrolling
              ? AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    // Calculate the actual offset based on the animation value relative to the scroll distance
                    // _controller.value goes from 0 to 1.0 in repeat mode
                    final scrollDistance = _textWidth + widget.blankSpace;
                    // The offset should move the text left by the scroll distance as value goes from 0 to 1
                    final animatedOffset = -_controller.value * scrollDistance;

                    return OverflowBox(
                      // Allow the child (the Text widget) to be wider than the container
                      maxWidth: double.infinity, // Allows child to take natural width
                      // maxHeight: _textHeight, // Also constrain height here for safety, though outer SizedBox should handle it
                      alignment: Alignment.topLeft, // Start the text from the left
                      child: Transform.translate(
                        // Apply the animated horizontal offset
                        offset: Offset(animatedOffset, 0.0),
                        child: Text(
                           // Repeat text + blank space for smooth loop
                          _needsScrolling ? "${widget.text}${List.filled(widget.blankSpace.round(), ' ').join()}${widget.text}" : widget.text,
                          style: widget.style,
                          maxLines: 1, // Crucial: Keep text on a single line
                          softWrap: false, // Prevent wrapping
                        ),
                      ),
                    );
                  },
                )
              : Text(
                  // Text fits, display normally with ellipsis if still needed (shouldn't be with softWrap: false)
                  widget.text,
                  style: widget.style,
                   // Overflow.ellipsis is usually not needed with softWrap: false, but can be kept as a fallback
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false, // Prevent wrapping
                ),
        );
      },
    );
  }
}