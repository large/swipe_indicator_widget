import 'package:flutter/material.dart';
import 'circle/circle.dart';

class SwipeIndicatorWidget {
  SwipeIndicatorWidget._();

  static Widget circle({
    required Color color,
    required Color borderColor,
    required Size size,
    final Function? onAnimationComplete,
    final int repeats = 2,
    Key? key,
  }) {
    return Circle(
      color: color,
      borderColor: borderColor,
      size: size,
      onAnimationComplete: onAnimationComplete,
      repeats: repeats,
      key: key,
    );
  }
}
