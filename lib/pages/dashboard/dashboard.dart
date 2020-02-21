import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/dashboard/addDevice.dart';
import 'package:home_ass/pages/dashboard/deviceWidgets.dart';
import 'package:home_ass/pages/devices/devicesTab.dart';
import 'package:home_ass/pages/settings/profile.dart';
import 'package:home_ass/utils/mysql/getRequests.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';

// TODO Add backend rooms (MySQL + shared pref)
String textGateway;
Color textGatewayColor;
final List<String> listRoomNames = <String>[
  'Living room',
  'Bed room',
  'Kitchen',
  'Gadget 4'
];

final List<String> listRoomImages = <String>[
  'lib/assets/livingroom.png',
  'lib/assets/bedroom.png',
  'lib/assets/kitchen.png',
  'lib/assets/bathroom.png',
];

Curve animationCurve = Curves.ease;

class DashboardIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(getGatewayStatus() == true){
      textGateway = "Gateway is connected with your phone!";
      textGatewayColor = Colors.green;
    }
    else{
      textGateway = "Gateway is not connected with your phone!";
      textGatewayColor = Colors.red;
    }

    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                    child: Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                        relativeOffset: 0.4,
                        from: Duration(milliseconds: 100),
                        to: Duration(seconds: 1),
                      ),
                      animateExit: false,
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Welcome home",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17
                            ),
                          ),
                          Text(
                            "Florian Pollakowsky",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Hero(
                  tag: "profileImage",
                  child: Material(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: ProfilePage(opacityVal: 1))),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        height: 64,
                        width: 64,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 140,
              margin: EdgeInsets.only(top: 32),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listRoomNames.length,
                  itemBuilder: (BuildContext context, int index){
                    return Villain(
                      villainAnimation: VillainAnimation.fromBottom(
                        relativeOffset: 0.4,
                        from: Duration(milliseconds: 100),
                        to: Duration(seconds: 1),
                      ),
                      animateExit: false,
                      secondaryVillainAnimation: VillainAnimation.fade(),
                      child: Hero(
                          tag: listRoomNames[index],
                          child: Container(
                              width: 132,
                              margin: EdgeInsets.only(right: 8),
                              child: Material(
                                color: primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(24)),
                                child: InkWell(
                                    onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: DevicesTab(roomName: listRoomNames[index]))),
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Image(image: AssetImage(listRoomImages[index]), height: 32),
                                                // TODO Add label which show if device is online or not
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    listRoomNames[index],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                  Text(
                                                    "1 Device",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10
                                                    ),
                                                  )
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              )
                          )
                      ),
                    );
                  }
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 32),
                child: Villain(
                  villainAnimation: VillainAnimation.fromBottom(
                    relativeOffset: 0.4,
                    from: Duration(milliseconds: 100),
                    to: Duration(seconds: 1),
                  ),
                  animateExit: false,
                  secondaryVillainAnimation: VillainAnimation.fade(),
                  child: Text(
                    textGateway,
                    style: TextStyle(
                        fontSize: 17,
                        color: textGatewayColor
                    ),
                  ),
                )
            ),
            Container(
                margin: EdgeInsets.only(top: 16),
                child: Villain(
                  villainAnimation: VillainAnimation.fromBottom(
                    relativeOffset: 0.4,
                    from: Duration(milliseconds: 100),
                    to: Duration(seconds: 1),
                  ),
                  animateExit: false,
                  secondaryVillainAnimation: VillainAnimation.fade(),
                  child:  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: 72,
                          decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(16))
                          ),
                          child: Row(
                            children: <Widget>[
                              Image(
                                  image: AssetImage("lib/assets/thermostat.png"),
                                  height: 40,
                                  color: Colors.white
                              ),
                              Expanded(
                                  child: Text(
                                    sensorData[1].toStringAsFixed(1) + "°C",
                                    style: dashboardCard2,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 72,
                          decoration: BoxDecoration(
                            color: cardColor,
                          ),
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage("lib/assets/humidity.png"),
                                height: 40,
                                color: Colors.white,
                              ),
                              Expanded(
                                  child: Text(
                                    sensorData[2].toStringAsFixed(0) + "%",
                                    style: dashboardCard2,
                                    textAlign: TextAlign.center,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 2),
                          padding: EdgeInsets.only(left: 8),
                          height: 72,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(16))
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.devices, size: 40, color: Colors.white),
                              Expanded(
                                child: Text(
                                  deviceCount.toString(),
                                  style: dashboardCard2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Villain(
                villainAnimation: VillainAnimation.fromBottom(
                  relativeOffset: 0.4,
                  from: Duration(milliseconds: 100),
                  to: Duration(seconds: 1),
                ),
                animateExit: false,
                secondaryVillainAnimation: VillainAnimation.fade(),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Connected Devices",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: (){
                        Navigator.of(context).push(PageTransition(type: PageTransitionType.rippleRightUp, child: AddDevicePage(),duration: Duration(milliseconds: 400)));
                      }
                    )
                  ],
                ),
              )
            ),
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 240,
                      margin: EdgeInsets.only(right: 4),
                      child: DeviceWidgetsLeft()
                    )
                  ),
                  Expanded(
                    child: Container(
                      height: 240,
                      margin: EdgeInsets.only(left: 4),
                      child: DeviceWidgetsRight()
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}