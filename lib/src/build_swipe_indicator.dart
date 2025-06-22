import 'package:flutter/material.dart';
import 'package:swipe_indicator_widget/src/swipedoublezoom/swipedoublezoom.dart';
import 'package:swipe_indicator_widget/src/swipezoom/swipezoom.dart';
import 'swipeup/swipeup.dart';

class SwipeIndicatorWidget {
  SwipeIndicatorWidget._();

  //SwipeUp static creator
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

  //SwipeZoom static creator
  static Widget swipeZoom({
    required Color color,
    required Color dotColor,
    required Color borderColor,
    required Color borderDotColor,
    required Size size,
    final Function? onAnimationComplete,
    final int repeats = 2,
    final double borderWidth = 1.0,
    final int waitTimeBetweenRepeats = 0,
    Key? key,
  }) {
    return SwipeZoom(
      color: color,
      dotColor: dotColor,
      borderColor: borderColor,
      borderDotColor: borderDotColor,
      size: size,
      onAnimationComplete: onAnimationComplete,
      repeats: repeats,
      key: key,
      borderWidth: borderWidth,
      waitTimeBetweenRepeats: waitTimeBetweenRepeats,
    );
  }

  //SwipeZoom static creator
  static Widget swipeDoubleZoom({
    required Color color,
    required Color dotColor,
    required Color borderColor,
    required Color borderDotColor,
    required double heightAndWidth,
    required Size windowSize,
    final Function? onAnimationComplete,
    final int repeats = 2,
    final double borderWidth = 1.0,
    final int waitTimeBetweenRepeats = 0,
    Key? key,
  }) {
    return SwipeDoubleZoom(
      windowSize: windowSize,
      color: color,
      dotColor: dotColor,
      borderColor: borderColor,
      borderDotColor: borderDotColor,
      heightAndWidth: heightAndWidth,
      onAnimationComplete: onAnimationComplete,
      repeats: repeats,
      key: key,
      borderWidth: borderWidth,
      waitTimeBetweenRepeats: waitTimeBetweenRepeats,
    );
  }
}
