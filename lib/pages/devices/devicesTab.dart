import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/devices/lights.dart';
import 'package:home_ass/pages/devices/sockets.dart';
import 'package:home_ass/pages/devices/thermostat.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
    // TODO add value to db
  },
);
String percentageModifier(double value) {
  final roundedValue = value.ceil().toInt().toString();
  return '$roundedValue °C';
}

void main() => runApp(DevicesTab());

class DevicesTab extends StatefulWidget{
  @required
  final String roomName;

  DevicesTab({
    this.roomName
  });

  @override
  _DevicesTab createState() => _DevicesTab();
}

class _DevicesTab extends State<DevicesTab> {


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
    return  WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: primaryColor,
          child: SafeArea(
            child: Container(
              color: Colors.white,
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
                            children: <Widget>[
                              IconButton(
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
                                child: Container(
                                  padding: EdgeInsets.only(left: 8),
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
                              ),
                              IconButton(
                                icon: Icon(
                                    Icons.add,
                                    color: Colors.white
                                ),
                                onPressed: (){
                                  // TODO add onPressed
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: opacity,
                    child: Container(
                      height: 98,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: deviceNames.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: IconButton(
                                          iconSize: iconSize,
                                          icon: Image(
                                            image: AssetImage(deviceIcons[index]),
                                            color: listColor[index],
                                          ),
                                          onPressed: (){
                                            for(var i = 0; i<listColor.length; i++){
                                              listColor[i] = Colors.grey;
                                            }
                                            _controller.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.decelerate);
                                            listColor[index] = primaryColor;
                                            setState(() {});
                                          },
                                        )
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                        deviceNames[index],
                                        style: TextStyle(
                                            color: listColor[index],
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            );
                          }
                      )
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 2),
                      opacity: opacity,
                      child: Container(
                        child: PageView(
                          // TODO Jump to page
                          physics: NeverScrollableScrollPhysics(),
                          controller: _controller,
                          children: <Widget>[
                            AllLights(),
                            Thermostats(),
                            Thermostats(),
                            Thermostats(),
                            Thermostats(),
                            Sockets(),
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            )
          )
      ),
    );
  }
}