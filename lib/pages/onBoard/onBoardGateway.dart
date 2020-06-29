import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/onBoardGatewayFound.dart';
import 'package:home_ass/pages/onBoard/onBoardGatewayNotFound.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

String txtGateway;

class OnBoardGateway extends StatefulWidget{
  _OnBoardGateway createState() => _OnBoardGateway();
}

class _OnBoardGateway extends State<OnBoardGateway> {
  startTimeout([int milliseconds]) {
    Timer(Duration(seconds: 3), () {
      setValueSharedPref("firstStart", false,"bool");
      initDashboard(context, true);
      //Navigator.of(context).push(FadeRouteBuilder(page: OnBoardFourth()));
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
      return OnBoardGatewayFound(txtGateway: txtGateway,);
    }
    else{
      return OnBoardGatewayNotFound();
    }
  }
}
