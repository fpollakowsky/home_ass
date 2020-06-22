import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/onBoard/3.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';
import 'package:home_ass/utils/res/global.dart';

Timer timer;

class E101 extends StatefulWidget{
  _E101 createState() => _E101();
}

class _E101 extends State<E101> {

  startTimeout([int milliseconds]) {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).push(FadeRouteBuilder(page: OnBoardThird()));
    });
  }

  pingGatewayLocal() async {
    final String ip = await Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 1883;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
        gatewayIPs.add(addr.ip);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pingGatewayLocal().then((val){
      //startTimeout();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: Material(
            color: themeColor,
            child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Villain(
                        villainAnimation: VillainAnimation.fromBottom(
                          relativeOffset: 0.3,
                          from: Duration(milliseconds: 500),
                          to: Duration(milliseconds: 1000)
                        ),
                        secondaryVillainAnimation: VillainAnimation.fade(),
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          alignment: Alignment.center,
                          child:Text(
                            "There is no connection to gateway",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ),
                      Expanded(
                        child: Villain(
                          villainAnimation: VillainAnimation.fade(
                            from: Duration(milliseconds: 800),
                            to: Duration(milliseconds: 1500),
                            curve: Curves.easeInSine
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: SpinKitWave(
                              color: Colors.white,
                              size: 96,
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}