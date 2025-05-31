import 'package:flutter/material.dart';

class SwipeZoom extends StatefulWidget {
  final Size size;
  final Color color;
  final Color borderColor;
  final Color dotColor;
  final Color borderDotColor;
  final int repeats;
  final Function? onAnimationComplete;
  final double borderWidth;
  final int waitTimeBetweenRepeats;

  const SwipeZoom({
    super.key,
    required this.size,
    required this.color,
    required this.dotColor,
    required this.borderColor,
    required this.borderDotColor,
    this.onAnimationComplete,
    this.repeats = 2,
    this.borderWidth = 1.0,
    this.waitTimeBetweenRepeats = 0,
  });

  @override
  State<SwipeZoom> createState() => _SwipeZoomState();
}

class _SwipeZoomState extends State<SwipeZoom>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _repeats = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    //Callback on animations
    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _repeats++;
        if (_repeats < widget.repeats) {
          //Sleep time between each repeat
          if (widget.waitTimeBetweenRepeats > 0) {
            await Future.delayed(
              Duration(milliseconds: widget.waitTimeBetweenRepeats),
            );
          }
          _animationController.reset();
          _animationController.forward();
        } else {
          if (widget.onAnimationComplete != null) widget.onAnimationComplete!();
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
      alignment: Alignment.center,
      width: widget.size.width,
      height: widget.size.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return AnimatedOpacity(
            opacity: Tween<double>(begin: 1.0, end: 0.0)
                .animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInExpo,
                  ),
                )
                .value,
            duration: const Duration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Draw blob with dot animation to the left
                blob(true),

                //Increase padding horizontal to push each dot to the sides
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        Tween<double>(
                              begin: 0.0,
                              end:
                                  (widget.size.width / 2) -
                                  widget.size.height * 1.3,
                            )
                            .animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: Curves.easeInOutQuart,
                              ),
                            )
                            .value,
                  ),
                ),

                //Draw blob to the right
                blob(false),
              ],
            ),
          );
        },
      ),
    );
  }

  //Widget "blob" indicator
  Widget blob(bool left) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        borderRadius: BorderRadius.circular(widget.size.height / 2),
        color: widget.color,
      ),
      height: widget.size.height,
      //Set width of "blob" based on the height & two different curves
      width:
          widget.size.height +
          Tween<double>(begin: 0.0, end: widget.size.height)
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOutQuart,
                ),
              )
              .value -
          Tween<double>(begin: 0.0, end: widget.size.height)
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.linear,
                ),
              )
              .value,
      //Alignment of the blob is based on the parent size
      alignment: left ? Alignment.centerLeft : Alignment.centerRight,
      //This dot is "static" base on the parent size, seems like moving
      child: Padding(
        padding: EdgeInsets.only(left: left ? 10 : 0, right: left ? 0 : 10),
        //DOT in the middle
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
    );
  }
}
