import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

class SettingsIndex extends StatefulWidget{
  @override
  _SettingsIndex createState() => _SettingsIndex();
}

class _SettingsIndex extends State<SettingsIndex>
  with SingleTickerProviderStateMixin{
  var rotation_1 = 0.0;
  var rotation_2 = 0.0;
  AnimationController buttonAnimationController;

  buttonAnimation(){
    if (buttonAnimationController.value == 1){
      buttonAnimationController.animateTo(0);
    }
    else{
      buttonAnimationController.animateTo(1);
    }
  }

  @override
  void initState(){
    super.initState();
    buttonAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryDarkColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: primaryColor,
              height: 62,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(
                        "Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 4),
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 96,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(image: NetworkImage("https://via.placeholder.com/72"),),
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
                            child: Text("Name", style: settingsH1)
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
                color: primaryDarkColor,
                padding: EdgeInsets.all(8),
                child: Container(
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
                                  child: CustomSwitchButton_1(
                                    height: 32,
                                    width: 72,
                                    borderRadius: 4,
                                    value: true,
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
                                Icon(Icons.fingerprint,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Fingerprint", style: settingsH3),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: CustomSwitchButton_1(
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
                            margin: EdgeInsets.only(top: 8),
                            child: Text("Account", textAlign: TextAlign.left, style: settingsH3B),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            height: 48,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Personal Information", style: settingsH3),
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: buttonAnimationController,
                                  builder: (BuildContext context, Widget _widget){
                                    return Transform.rotate(
                                      angle: buttonAnimationController.value * rotation_1,
                                      child: _widget,
                                    );
                                  },
                                  child: IconButton(
                                    icon: Icon(Icons.navigate_next, size: 32),
                                    color: Colors.grey,
                                    onPressed: (){
                                      setState(() {
                                        rotation_1 = 1.6;
                                        rotation_2 = 0;
                                        buttonAnimation();
                                      });
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
                                Icon(Icons.language,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Language", style: settingsH3),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("English", style: settingsH4G),
                                ),
                                Icon(Icons.navigate_next,size: 32, color: Colors.grey),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text("Gateway", textAlign: TextAlign.left, style: settingsH3B),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            height: 48,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.settings_input_antenna,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("IP Address", style: settingsH3),
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: buttonAnimationController,
                                  builder: (BuildContext context, Widget _widget){
                                    return Transform.rotate(
                                      angle: buttonAnimationController.value * rotation_2,
                                      child: _widget,
                                    );
                                  },
                                  child: IconButton(
                                    icon: Icon(Icons.navigate_next, size: 32),
                                    color: Colors.grey,
                                    onPressed: (){
                                      setState(() {
                                        rotation_1 = 0;
                                        rotation_2 = 1.6;
                                        buttonAnimation();
                                      });
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
                                Icon(Icons.data_usage,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Privacy mode", style: settingsH3),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text("Strict", style: settingsH4G),
                                ),
                                Icon(Icons.navigate_next,size: 32, color: Colors.grey),
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
                                Icon(Icons.devices,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("Technical support", style: settingsH3),
                                  ),
                                ),
                                Icon(Icons.navigate_next,size: 32, color: Colors.grey),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            height: 48,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.message,size: 32, color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text("General support", style: settingsH3),
                                  ),
                                ),
                                Icon(Icons.navigate_next,size: 32, color: Colors.grey),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}