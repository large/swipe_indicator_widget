import 'package:flutter/material.dart';
import '../build_swipe_indicator.dart';

class SwipeUp extends StatefulWidget {
  final Size size;
  final Color color;
  final Color borderColor;
  final Color dotColor;
  final Color borderDotColor;
  final int repeats;
  final Function? onAnimationComplete;

  const SwipeUp({
    super.key,
    required this.size,
    required this.color,
    required this.dotColor,
    required this.borderColor,
    required this.borderDotColor,
    this.onAnimationComplete,
    this.repeats = 2,
  });

  @override
  State<SwipeUp> createState() => _SwipeUpState();
}

class _SwipeUpState extends State<SwipeUp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _repeats = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    //Callback on animations
    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed)
        {
          _repeats++;
          if(_repeats < widget.repeats) {
            _animationController.reset();
            _animationController.forward();
          }
          else
          {
            if(widget.onAnimationComplete!=null) widget.onAnimationComplete!();
          }
        }
    });

    //Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: widget.size.width,
      height: widget.size.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: Tween<double>(
                        begin: 0.0, end: widget.size.height - widget.size.width)
                    .animate(CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOutQuart))
                    .value),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: widget.borderColor),
                borderRadius: BorderRadius.circular(widget.size.width / 2),
                color: widget.color,
              ),
              width: widget.size.width,
              height: widget.size.width +
                  Tween<double>(begin: 0.0, end: widget.size.width)
                      .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOutQuart))
                      .value -
                  Tween<double>(begin: 0.0, end: widget.size.width)
                      .animate(CurvedAnimation(
                          parent: _animationController, curve: Curves.linear))
                      .value,
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: Tween<double>(begin: widget.size.width / 3, end: widget.size.width/4)
                        .animate(CurvedAnimation(
                            parent: _animationController, curve: Curves.easeIn))
                        .value),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.borderDotColor),
                    borderRadius: BorderRadius.circular(5),
                    color: widget.dotColor,
                  ),
                  height: 10,
                  width: 10,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
