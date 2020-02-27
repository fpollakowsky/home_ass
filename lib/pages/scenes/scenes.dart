import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

// TODO Add scenes

class ScenesIndex extends StatefulWidget {
  @override
  _ScenesIndex createState() => new _ScenesIndex();
}

class _ScenesIndex extends State<ScenesIndex> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: themeColor,
      body: Container(
        alignment: Alignment.center,
        child: CustomSwitchVertical(
          height: 228,
          width: 96,
          borderRadius: 4,
          value: true,
          colorOn: Colors.green,
          colorOff: primaryColor,
          animationDuration: Duration(milliseconds: 200),
          onChanged: (bool state) {
          },
        ),
      )
    );
  }
}


