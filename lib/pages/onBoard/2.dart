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

class OnBoardSecond extends StatefulWidget{
  _OnBoardSecond createState() => _OnBoardSecond();
}

class _OnBoardSecond extends State<OnBoardSecond> {

  startTimeout([int milliseconds]) {
    Timer(Duration(seconds: 3), () {
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

  pingGatewayTest()async{
    const port = 1883;
    final stream = NetworkAnalyzer.discover2(
      '85.214.233', port,
      timeout: Duration(milliseconds: 5000),
    );

    int found = 0;
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        found++;
        print('Found device: ${addr.ip}:$port');
        gatewayIPs.add(addr.ip);
      }
    }).onDone(() => print('Finish. Found $found device(s)'));
  }

  @override
  void initState() {
    super.initState();
    pingGatewayTest().then((val){
      startTimeout();
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Hero(
                          tag: "logo",
                          child: Container(
                            height: 64,
                            width:  64,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                image: DecorationImage(
                                    image: NetworkImage("https://via.placeholder.com/256"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: Hero(
                                  tag: "txtLogo",
                                  child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                          "Placeholder",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.white
                                          )
                                      )
                                  )
                              )
                          ),
                        ),
                        Container(
                          height: 64,
                          width: 64,
                        )
                      ],
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
                    Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                          relativeOffset: 0.3,
                          from: Duration(milliseconds: 800),
                          to: Duration(milliseconds: 1300)
                      ),
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          child: Text(
                              "Searching for devices",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white
                              )
                          )
                      ),
                    )
                  ],
                ),
              )
          )
      )
    );
  }
}