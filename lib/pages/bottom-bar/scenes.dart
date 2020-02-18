import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/utils/res/styles.dart';

class ScenesIndex extends StatefulWidget {
  @override
  _ScenesIndex createState() => new _ScenesIndex();
}

class _ScenesIndex extends State<ScenesIndex> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Hero(tag: "profile", child: CircleAvatar(backgroundImage: AssetImage("assets/joe-gardner.jpg"))),
            onTap: () {
              Navigator.of(context).push(BlankRoute(ScenesIndex2()));
            },
          ),
        ),
      ),
    );
  }
}

class ScenesIndex2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(
                        tag: "profile",
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/joe-gardner.jpg"),
                          radius: 50.0,
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                        relativeOffset: 0.4,
                        from: Duration(milliseconds: 100),
                        to: Duration(seconds: 1),
                      ),
                      animateExit: false,
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Text(
                        "test",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlankRoute extends PageRoute {

  final Widget child;

  BlankRoute(this.child);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

}