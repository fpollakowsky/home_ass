import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/components/singleDevice.dart';
import 'package:home_ass/components/singleRoom.dart';
import 'package:home_ass/pages/devices/lights.dart';
import 'package:home_ass/pages/devices/sockets.dart';
import 'package:home_ass/pages/devices/thermostat.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

//#region Variables
double opacity = 0;
double iconSize = 40;
int index;
final List<String> deviceNames = <String>[
  'Lights',
  'Thermostat',
  'Fridge',
  'Fans',
  'Speaker',
  'Socket'
];
final List<Color> listColor = <Color>[
  primaryColor,
  Colors.grey,
  Colors.grey,
  Colors.grey,
  Colors.grey,
  Colors.grey
];
final List<String> deviceIcons = <String>[
  'lib/assets/light.png',
  'lib/assets/thermostat.png',
  'lib/assets/fridge.png',
  'lib/assets/fan.png',
  'lib/assets/speaker.png',
  'lib/assets/speaker.png'
];
final slider = SleekCircularSlider(
  min: 0,
  max: 40,
  initialValue: 25,
  appearance: CircularSliderAppearance(
      angleRange: 360,
      startAngle: 270,
      customWidths: CustomSliderWidths(
        handlerSize: 10,
        trackWidth: 2,
        progressBarWidth: 6
      ),
      customColors: CustomSliderColors(
        shadowColor: Colors.grey,
        shadowMaxOpacity: 2,
        shadowStep: 8,
        dotColor: primaryColor,
        trackColor: primaryColor,
        progressBarColor: primaryColor
      ),
      infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
          modifier: percentageModifier
      )
  ),
  onChange: (double value) {
    print(value);
  },
  onChangeEnd: (double value){
  },
);
String percentageModifier(double value) {
  final roundedValue = value.ceil().toInt().toString();
  return '$roundedValue °C';
}
//#endregion

class DevicesTab extends StatefulWidget{
  @required
  final String roomName;

  DevicesTab({
    this.roomName
  });

  @override
  _DevicePage createState() => _DevicePage();
}

class _DevicePage extends State<DevicesTab> {

  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    timer();
  }

  Future<Timer> timer() async {
    return new Timer(Duration(seconds: 1), onFinish);
  }
  onFinish() async {
    opacity = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: primaryColor,
        child: Container(
          decoration: BoxDecoration(
            color: themeColor,
          ),
          child: Column(
            children: <Widget>[
              Hero(
                  tag: widget.roomName,
                  child: Material(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 62,
                      color: primaryColor,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          IconButton(
                            iconSize: 32,
                            icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white
                            ),
                            onPressed: (){
                              opacity = 0;
                              setState(() {

                              });
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Text(
                              widget.roomName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22
                              ),
                            ),
                          ),
                          Container(
                            width: 48,
                          )
                        ],
                      ),
                    ),
                  )
              ),
              Expanded(
                child: SingleDevice(roomName: widget.roomName,),
              )
            ],
          ),
        )
      ),
    );
  }
}