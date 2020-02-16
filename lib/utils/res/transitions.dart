import 'package:flutter/cupertino.dart';

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