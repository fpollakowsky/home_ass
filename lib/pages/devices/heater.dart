import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

final slider = SleekCircularSlider(
  min: 0,
  max: 40,
  initialValue: 25,
  appearance: CircularSliderAppearance(
    angleRange: 360,
    customWidths: CustomSliderWidths(
      trackWidth: 1
    )
  ),
  onChange: (double value) {
    print(value);
  }
);

String percentageModifier(double value) {
  final roundedValue = value.ceil().toInt().toString();
  return '$roundedValue °C';
}

void main() => runApp(SliderTest());

class SliderTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        home: Material(
          child: Container(
            width: 100,
            height: 100,
            child: SleekCircularSlider(
                min: 0,
                max: 40,
                initialValue: 25,
                appearance: CircularSliderAppearance(
                    angleRange: 360,
                    customWidths: CustomSliderWidths(
                        trackWidth: 1,
                        progressBarWidth: 10
                    ),
                    customColors: CustomSliderColors(
                        progressBarColor: primaryColor
                    ),
                  infoProperties: InfoProperties(
                    modifier: percentageModifier
                  )
                ),
                onChange: (double value) {
                  print(value);
                }
            ),
          )
        )
    );
  }
}