import 'package:flutter/cupertino.dart';

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({
    @required
    this.page
  }) : super(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation1, animation2) => page,
    transitionsBuilder: (context, animation1, animation2, child) {
      return FadeTransition(opacity: animation1, child: child);
    },
  );
}

class SlideRouteBuilder extends PageRouteBuilder {
  final Widget page;

  SlideRouteBuilder({
    @required
    this.page,
  }) : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return new SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1 ,0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }
  );
}