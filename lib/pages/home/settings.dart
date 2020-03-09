import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/settings/accounts.dart';
import 'package:home_ass/pages/settings/profile.dart';
import 'package:home_ass/pages/settings/support.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:home_ass/utils/settingsPage.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

class Settings extends StatefulWidget{
  @override
  _SettingsIndex createState() => _SettingsIndex();
}

class _SettingsIndex extends State<Settings>
  with SingleTickerProviderStateMixin{

  @override
  void initState(){
    super.initState();
    loadSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Material(
      color: secondaryColor,
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
                    Hero(
                      tag: "profileImage",
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.white,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: ProfilePage(opacityVal: 1,))),
                          child: Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              image: DecorationImage(image: AssetImage(valProfile)),
                            )
                          ),
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
                                child: Text(valName, style: settingsH1),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Text("@"+ valNick, style: settingsH2)
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
                                    value: valNotification,
                                    colorOn: Colors.green,
                                    colorOff: primaryColor,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    onChanged: (bool state) {
                                      setValueSharedPref("notification", state, "bool");
                                      valNotification = state;
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
                                    value: valDarkMode,
                                    colorOn: Colors.green,
                                    colorOff: primaryColor,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    onChanged: (bool state) {
                                      valDarkMode = state;
                                      setValueSharedPref("darkmode", state, "bool");
                                      setThemeMode();
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
                                    child: Text("fingerprint", style: settingsH3),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: CustomSwitchHorizontal(
                                    height: 32,
                                    width: 72,
                                    borderRadius: 4,
                                    value: valFingerprint,
                                    colorOn: Colors.green,
                                    colorOff: primaryColor,
                                    iconOn: Icons.done,
                                    iconOff: Icons.remove_circle_outline,
                                    onChanged: (bool state) {
                                      setValueSharedPref("fingerprint", state, "bool");
                                      valFingerprint = state;
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
                                      value: valAbode,
                                      iconEnabledColor: Colors.grey,
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                      underline: Container(
                                        height: 0,
                                      ),
                                      onChanged: (String newValue) {
                                        setValueSharedPref("abode", newValue, "string");
                                        setState(() {
                                          valAbode = newValue;
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
                                                onSubmitted: (value){
                                                  valName = value;
                                                  setValueSharedPref("name", value, "string");
                                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                                  setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                  focusedBorder: focusedBorder,
                                                  border: border,
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                  labelText: "Name",
                                                  hintText: valName
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
                                                onSubmitted: (value){
                                                  valNick = value;
                                                  setValueSharedPref("nickname", value, "string");
                                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                                  setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                  focusedBorder: focusedBorder,
                                                  border: border,
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                  labelText: "Nickname",
                                                  hintText: valNick
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
                                            onSubmitted: (value){
                                              setValueSharedPref("password", value, "string");
                                              SystemChrome.setEnabledSystemUIOverlays([]);
                                              setState(() {});
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
                                      value: valLanguage,
                                      iconEnabledColor: Colors.grey,
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                      underline: Container(
                                        height: 0,
                                      ),
                                      onChanged: (String newValue) {
                                        setValueSharedPref("language", newValue, "string");
                                        setState(() {
                                          valLanguage = newValue;
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
                                                onSubmitted: (value){
                                                  valIP = value;
                                                  setValueSharedPref("ip", value, "string");
                                                  SystemChrome.setEnabledSystemUIOverlays([]);
                                                  initDashboard(context, false);
                                                  setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                  focusedBorder: focusedBorder,
                                                  border: border,
                                                  labelStyle: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                  labelText: "IP",
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
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.account_circle,size: 32, color: primaryColor),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        child: Text("Manage Accounts", style: settingsH3),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.navigate_next, size: 32),
                                      color: Colors.grey,
                                      onPressed: (){
                                        Navigator.of(context).push(PageTransition(type: PageTransitionType.rippleRightUp, child: AccountsPage(),duration: Duration(milliseconds: 400)));
                                      },
                                    ),
                                  ],
                                ),
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
                                      value: valPrivacy,
                                      iconEnabledColor: Colors.grey,
                                      style: TextStyle(
                                          color: Colors.grey
                                      ),
                                      underline: Container(
                                        height: 0,
                                      ),
                                      onChanged: (String newValue) {
                                        setValueSharedPref("privacy", newValue, "string");
                                        setState(() {
                                          valPrivacy = newValue;
                                        });
                                      },
                                      items: <String>['Advanced', 'Basic']
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