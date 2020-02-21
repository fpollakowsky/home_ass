import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/settings/profile.dart';
import 'package:home_ass/pages/settings/support.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:home_ass/utils/settingsPage.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

String dropdownLanguage = 'English';
String dropdownPrivacy = 'Advanced';
String dropdownAbode = 'Living Room';

class SettingsIndex extends StatefulWidget{
  @override
  _SettingsIndex createState() => _SettingsIndex();
}

class _SettingsIndex extends State<SettingsIndex>
  with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryDarkColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, bottom: 4,top: 8),
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 96,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: ProfilePage(opacityVal: 1,))),
                    child: Hero(
                      tag: "profileImage",
                      child: Container(
                          height: 72,
                          width: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: primaryColor,
                            //image: DecorationImage(image: NetworkImage("https://via.placeholder.com/72"),),
                          )
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: Text("Florian Pollakowsky", style: settingsH1),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text("Nickname", style: settingsH2)
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              )
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 24, left: 8, right: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("General", textAlign: TextAlign.left, style: settingsH3B),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.notifications,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Notification", style: settingsH3),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: CustomSwitchHorizontal(
                                  height: 32,
                                  width: 72,
                                  borderRadius: 4,
                                  value: true,
                                  colorOn: Colors.green,
                                  colorOff: primaryColor,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  onChanged: (bool state) {
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.view_module,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Dark mode", style: settingsH3),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: CustomSwitchHorizontal(
                                  height: 32,
                                  width: 72,
                                  borderRadius: 4,
                                  value: true,
                                  colorOn: Colors.green,
                                  colorOff: primaryColor,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  onChanged: (bool state) {
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.fingerprint,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Fingerprint", style: settingsH3),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: CustomSwitchHorizontal(
                                  height: 32,
                                  width: 72,
                                  borderRadius: 4,
                                  value: false,
                                  colorOn: Colors.green,
                                  colorOff: primaryColor,
                                  iconOn: Icons.done,
                                  iconOff: Icons.remove_circle_outline,
                                  offset: 48,
                                  onChanged: (bool state) {
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.home,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Main abode", style: settingsH3),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: DropdownButton<String>(
                                    value: dropdownAbode,
                                    iconEnabledColor: Colors.grey,
                                    style: TextStyle(
                                      color: Colors.grey
                                    ),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownAbode = newValue;
                                      });
                                    },
                                    items: <String>['Living Room', 'Kitchen', 'etc'] // TODO get this list from db
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text("Account", textAlign: TextAlign.left, style: settingsH3B),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 4),
                            //height: 48,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.person,size: 32, color: primaryColor),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("Personal Information", style: settingsH3),
                                      ),
                                    ),
                                    Villain(
                                      villainAnimation: VillainAnimation.transformRotate(
                                        fromAngle: angleFirst[0],
                                        toAngle: angleSecond[0],
                                        to: Duration(milliseconds: 100),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.navigate_next, size: 32),
                                        color: Colors.grey,
                                        onPressed: (){
                                          VillainController.playAllVillains(context);
                                          buttonAnimation(0);
                                          containerAnimation(0);
                                          setState(() {});
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  height: containerHeight[0],
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Villain(
                                          villainAnimation: VillainAnimation.fromBottom(
                                            relativeOffset: 0.4,
                                            from: Duration(milliseconds: 100),
                                            to: Duration(milliseconds: 600),
                                          ),
                                          animateExit: true,
                                          secondaryVillainAnimation: VillainAnimation.fade(),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: TextField(
                                              onSubmitted: (bool){
                                                SystemChrome.setEnabledSystemUIOverlays([]);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: focusedBorder,
                                                border: border,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey
                                                ),
                                                labelText: 'Name',
                                              ),
                                            ),
                                          )
                                      ),
                                      Villain(
                                          villainAnimation: VillainAnimation.fromBottom(
                                            relativeOffset: 0.4,
                                            from: Duration(milliseconds: 200),
                                            to: Duration(milliseconds: 700),
                                          ),
                                          animateExit: true,
                                          secondaryVillainAnimation: VillainAnimation.fade(),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 4),
                                            child: TextField(
                                              onSubmitted: (bool){
                                                SystemChrome.setEnabledSystemUIOverlays([]);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: focusedBorder,
                                                border: border,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey
                                                ),
                                                labelText: 'Nickname',
                                              ),
                                            ),
                                          )
                                      ),
                                      Villain(
                                        villainAnimation: VillainAnimation.fromBottom(
                                          relativeOffset: 0.4,
                                          from: Duration(milliseconds: 300),
                                          to: Duration(milliseconds: 800),
                                        ),
                                        animateExit: true,
                                        secondaryVillainAnimation: VillainAnimation.fade(),
                                        child: TextField(
                                          onSubmitted: (bool){
                                            SystemChrome.setEnabledSystemUIOverlays([]);
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            focusedBorder: focusedBorder,
                                            border: border,
                                            labelStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            labelText: 'Password',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.language,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Language", style: settingsH3),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: DropdownButton<String>(
                                    value: dropdownLanguage,
                                    iconEnabledColor: Colors.grey,
                                    style: TextStyle(
                                        color: Colors.grey
                                    ),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownLanguage = newValue;
                                      });
                                    },
                                    items: <String>['English', 'German']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text("Gateway", textAlign: TextAlign.left, style: settingsH3B),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.settings_input_antenna,size: 32, color: primaryColor),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("IP Address", style: settingsH3),
                                      ),
                                    ),
                                    Villain(
                                      villainAnimation: VillainAnimation.transformRotate(
                                        fromAngle: angleFirst[1],
                                        toAngle: angleSecond[1],
                                        to: Duration(milliseconds: 100),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.navigate_next, size: 32),
                                        color: Colors.grey,
                                        onPressed: (){
                                          VillainController.playAllVillains(context);
                                          buttonAnimation(1);
                                          containerAnimation(1);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  height: containerHeight[1],
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: <Widget>[
                                      Villain(
                                          villainAnimation: VillainAnimation.fromBottom(
                                            relativeOffset: 0.4,
                                            from: Duration(milliseconds: 100),
                                            to: Duration(milliseconds: 600),
                                          ),
                                          animateExit: true,
                                          secondaryVillainAnimation: VillainAnimation.fade(),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 8),
                                            child: TextField(
                                              onSubmitted: (bool){
                                                SystemChrome.setEnabledSystemUIOverlays([]);
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder: focusedBorder,
                                                border: border,
                                                labelStyle: TextStyle(
                                                    color: Colors.grey
                                                ),
                                                labelText: 'IP',
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.data_usage,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Privacy mode", style: settingsH3),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: DropdownButton<String>(
                                    value: dropdownPrivacy,
                                    iconEnabledColor: Colors.grey,
                                    style: TextStyle(
                                        color: Colors.grey
                                    ),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownPrivacy = newValue;
                                      });
                                    },
                                    items: <String>['Advanced', 'Basic'] // TODO set this value to db
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text("Contact", textAlign: TextAlign.left, style: settingsH3B),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          height: 48,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add_comment,size: 32, color: primaryColor),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Support", style: settingsH3),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.navigate_next, size: 32),
                                color: Colors.grey,
                                splashColor: primaryColor,
                                enableFeedback: true,
                                onPressed: (){
                                  Navigator.of(context).push(PageTransition(type: PageTransitionType.rippleRightUp, child: SupportPage(),duration: Duration(milliseconds: 400)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}