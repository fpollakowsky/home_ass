import 'package:flutter/cupertino.dart';

int milliStart = 1100;
int milliEnd = 1800;

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;
  final int transitionTime;

  FadeRouteBuilder({
    @required
    this.page,
    this.transitionTime = 1
  }) : super(
    transitionDuration: Duration(seconds: transitionTime),
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation1, animation2, child) {
      return FadeTransition(opacity: animation1, child: child);
    },
  );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionDuration: Duration(seconds: 1),
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class SlideRouteBuilder extends PageRouteBuilder {
  final Widget page;
  final double offsetX;
  final double offsetY;

  SlideRouteBuilder({
    @required
    this.page,
    this.offsetX = -1,
    this.offsetY = 0
  }) : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: Offset(offsetX , offsetY),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}

setAnimationTime(){
  milliStart = milliStart + 150;
  milliEnd = milliEnd + 150;
}