import 'package:flutter/material.dart';
import 'package:swipe_indicator_widget/src/swipezoom/swipezoom.dart';

class SwipeDoubleZoom extends StatefulWidget {
  final double heightAndWidth;
  final Size windowSize;
  final Color color;
  final Color borderColor;
  final Color dotColor;
  final Color borderDotColor;
  final int repeats;
  final Function? onAnimationComplete;
  final double borderWidth;
  final int waitTimeBetweenRepeats;

  const SwipeDoubleZoom({
    super.key,
    required this.heightAndWidth,
    required this.color,
    required this.dotColor,
    required this.borderColor,
    required this.borderDotColor,
    this.onAnimationComplete,
    this.repeats = 2,
    this.borderWidth = 1.0,
    this.waitTimeBetweenRepeats = 0,
    required this.windowSize,
  });

  @override
  State<SwipeDoubleZoom> createState() => _SwipeDoubleZoomState();
}

class _SwipeDoubleZoomState extends State<SwipeDoubleZoom>
    with SingleTickerProviderStateMixin {
  late SwipeZoom zoomHorizontal;
  late SwipeZoom zoomVertical;

  @override
  void initState() {
    super.initState();

    //Create vertical view
    zoomVertical = SwipeZoom(
      size: Size(widget.windowSize.height, widget.heightAndWidth),
      color: widget.color,
      dotColor: widget.dotColor,
      borderColor: widget.borderColor,
      borderDotColor: widget.borderDotColor,
      repeats: widget.repeats,
      borderWidth: widget.borderWidth,
      waitTimeBetweenRepeats: widget.waitTimeBetweenRepeats,
    );

    //Create horizontal view
    zoomHorizontal = SwipeZoom(
      size: Size(widget.windowSize.width, widget.heightAndWidth),
      color: widget.color,
      dotColor: widget.dotColor,
      borderColor: widget.borderColor,
      borderDotColor: widget.borderDotColor,
      repeats: widget.repeats,
      borderWidth: widget.borderWidth,
      waitTimeBetweenRepeats: widget.waitTimeBetweenRepeats,
      onAnimationComplete: () {
        if (widget.onAnimationComplete != null) widget.onAnimationComplete!();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.windowSize.width,
      height: widget.windowSize.height,
      child: Stack(
        children: [
          Center(child: zoomHorizontal),
          RotatedBox(quarterTurns: 1, child: Center(child: zoomVertical)),
        ],
      ),
    );
  }
}
