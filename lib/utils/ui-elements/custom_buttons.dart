library lite_rolling_switch;

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

class CustomSwitchButton_1 extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;
  final int offset;
  final double height;
  final double width;
  final double borderRadius;

  CustomSwitchButton_1(
      {this.value = false,
        this.textOff = "Off",
        this.textOn = "On",
        this.textSize = 14,
        this.colorOn = Colors.green,
        this.colorOff = Colors.red,
        this.iconOff = Icons.flag,
        this.iconOn = Icons.check,
        this.animationDuration = const Duration(milliseconds: 600),
        this.onTap,
        this.onDoubleTap,
        this.onSwipe,
        this.onChanged,
        this.offset,
        this.height = 40,
        this.width = 96,
        this.borderRadius = 24,
      });

  @override
  _CustomSwitchButton_1 createState() => _CustomSwitchButton_1();
}

class _CustomSwitchButton_1 extends State<CustomSwitchButton_1>
  with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;
  bool turnState;
  double containerWidth;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    containerWidth = widget.width / 3;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
        //widget.onSwipe();
      },
      child: Container(
        padding: EdgeInsets.all(4),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(widget.borderRadius)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  height: 40,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(8 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(((widget.width - containerWidth) - 8 )* value, 0),
              child: Container(
                  height: 40,
                  width: containerWidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      color: Colors.white
                  ),
                  child: Transform.rotate(
                    angle: lerpDouble(0, 2 * pi, value),
                    child:  Stack(
                      children: <Widget>[
                        Center(
                          child: Opacity(
                            opacity: (1 - value).clamp(0.0, 1.0),
                            child: Icon(
                              widget.iconOff,
                              size: 25,
                              color: transitionColor,
                            ),
                          ),
                        ),
                        Center(
                            child: Opacity(
                                opacity: value.clamp(0.0, 1.0),
                                child: Icon(
                                  widget.iconOn,
                                  size: 21,
                                  color: transitionColor,
                                )
                            )
                        ),
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}