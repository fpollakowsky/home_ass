import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

String txtGateway;

class AddDevice extends StatefulWidget{
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  startTimeout([int milliseconds]) {
    Timer(Duration(seconds: 5), () {
      initDashboard(context, true);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    if(gatewayIPs.length != 0){
      if (gatewayIPs.length > 1){
        txtGateway = "Gateways found";
      }
      else{
        txtGateway = "Gateway found";
        setValueSharedPref("ip", gatewayIPs[0] ,"string");
      }
      setValueSharedPref("firstStart", false, "bool");
      startTimeout();
      return GatewayFound();
    }
    else{
      return GatewayNotFound();
    }
  }
}
class GatewayFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
        color: themeColor,
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: Villain(
                          villainAnimation: VillainAnimation.fromBottom(
                              relativeOffset: 0.4,
                              from: Duration(milliseconds: 800),
                              to: Duration(milliseconds: 1300)
                          ),
                          secondaryVillainAnimation: VillainAnimation.fade(),
                          child: Text(
                              txtGateway,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.7
                              )
                          )
                      )
                  ),
                  Villain(
                    villainAnimation: VillainAnimation.fade(
                        from: Duration(milliseconds: 1000),
                        to: Duration(milliseconds: 1700),
                        fadeFrom: 0,
                        fadeTo: 1
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 64),
                      height: 256,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("lib/assets/success.png"))
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}
class GatewayNotFound extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Material(
        color: themeColor,
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.center,
                      child: Villain(
                          villainAnimation: VillainAnimation.fromBottom(
                              relativeOffset: 0.4,
                              from: Duration(milliseconds: 800),
                              to: Duration(milliseconds: 1300)
                          ),
                          secondaryVillainAnimation: VillainAnimation.fade(),
                          child: Text(
                              "Gateway not found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.7
                              )
                          )
                      )
                  ),
                  Villain(
                    villainAnimation: VillainAnimation.fade(
                        from: Duration(milliseconds: 1000),
                        to: Duration(milliseconds: 1700),
                        fadeFrom: 0,
                        fadeTo: 1
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 64),
                      height: 256,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("lib/assets/failure.png"))
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.bottomCenter,
                        child: ButtonTheme(
                          minWidth: 256,
                          height: 40,
                          child: FlatButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            onPressed: (){},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(color: Colors.red)
                            ),
                            child: Text("Add manually"),
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}