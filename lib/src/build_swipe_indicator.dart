import 'package:flutter/material.dart';
import 'swipeup/swipeup.dart';

class SwipeIndicatorWidget {
  SwipeIndicatorWidget._();

  static Widget swipeUp({
    required Color color,
    required Color dotColor,
    required Color borderColor,
    required Color borderDotColor,
    required Size size,
    final Function? onAnimationComplete,
    final int repeats = 2,
    Key? key,
  }) {
    return SwipeUp(
      color: color,
      dotColor: dotColor,
      borderColor: borderColor,
      borderDotColor: borderDotColor,
      size: size,
      onAnimationComplete: onAnimationComplete,
      repeats: repeats,
      key: key,
    );
  }
}
