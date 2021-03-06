import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/home.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  @required
  double opacityVal;

  ProfilePage({
    this.opacityVal
  });

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: themeColor,
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Hero(
                tag: "profileImage",
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.opacityVal = 0;
                      });
                      Navigator.of(context).push(FadeRouteBuilder(page: HomeScreen(index: 2)));
                    },
                    child: Container(
                      height: 228,
                      width: 228,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(image: AssetImage(valProfile))
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                curve: Curves.linear,
                opacity: widget.opacityVal,
                child: Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                          relativeOffset: 0.2,
                          from: Duration(milliseconds: 500),
                          to: Duration(seconds: 1),
                          curve: Curves.easeIn
                      ),
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Text(
                        valName,
                        style: TextStyle(
                            color: labelColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                curve: Curves.easeIn,
                opacity: widget.opacityVal,
                child: Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                          relativeOffset: 0.2,
                          from: Duration(milliseconds: 700),
                          to: Duration(milliseconds: 1200),
                          curve: Curves.easeIn
                      ),
                      animateExit: true,
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Text(
                        "@" + valNick,
                        style: TextStyle(
                            color: labelColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

