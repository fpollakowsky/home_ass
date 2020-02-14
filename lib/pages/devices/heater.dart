import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

double opacity = 0;
int index;
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

void main() => runApp(SliderTest());

class SliderTest extends StatefulWidget{
  @override
  _SliderTest createState() => _SliderTest();
}

class _SliderTest extends State<SliderTest> {
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
                      tag: "roomContainer",
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
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Bathroom",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22
                                  ),
                                ),
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(500)),
                                      border: Border.all(color: lightBorderColor),
                                    ),
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50)),
                                        ),
                                        color: lightBoxColor,
                                        onPressed: (){},
                                        child: Icon(Icons.lightbulb_outline,size: 32, color: lightIconColor,)
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Light",
                                      style: TextStyle(
                                          color: lightTextColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(500)),
                                      border: Border.all(color: heaterBorderColor),
                                    ),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                      ),
                                      color: heaterBoxColor,
                                      onPressed: (){},
                                      child: Image(image: AssetImage("lib/assets/heater.png"),height: 30, color: heaterIconColor),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "Heater",
                                      style: TextStyle(
                                          color: heaterTextColor,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (val){
                        index = val;
                      },
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: opacity,
                                  child: SleekCircularSlider(
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
                                            shadowMaxOpacity: 0.2,
                                            shadowStep: 4,
                                            dotColor: primaryColor,
                                            trackColor: Colors.grey,
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
                                  ),
                                )
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Expanded(
                                child: AnimatedOpacity(
                                  duration: Duration(seconds: 1),
                                  opacity: opacity,
                                  child: SleekCircularSlider(
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
                                            shadowMaxOpacity: 0.2,
                                            shadowStep: 4,
                                            dotColor: primaryColor,
                                            trackColor: Colors.grey,
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
                                  ),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: opacity,
                    child: Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              width: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("Current temperature", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text("12 °C", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      ),
                                      Container(
                                        height: 36,
                                        width: 96,
                                        child: LiteRollingSwitch(
                                          value: true,
                                          colorOn: primaryColor,
                                          colorOff: Colors.green,
                                          iconOn: Icons.done,
                                          iconOff: Icons.remove_circle_outline,
                                          textSize: 12,
                                          offset: 48,
                                          onChanged: (bool state) {
                                            //Use it to manage the different states
                                            print('Current State of SWITCH IS: $state');
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ButtonTheme(
                              height: 48,
                              minWidth: double.infinity,
                              child: RaisedButton(
                                color: primaryColor,
                                onPressed: (){},
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                ),
                                child: Text(
                                  "Set temperature",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            )
          )
      ),
    );
  }
}