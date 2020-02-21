import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/dashboard/dashboard.dart';
import 'package:home_ass/utils/mysql/getRequests.dart';
import 'package:home_ass/utils/mysql/setRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

int milliStart = 0;
int milliEnd = 700;
bool buttonState;

switchButtonOnChanged(int index, bool state, bool isRight){
  if (isRight == false && state == true){
    setDeviceValue(true, deviceIDLeft[index]);
  }
  else if(isRight == false && state == false){
    setDeviceValue(false, deviceIDLeft[index]);
  }
  else if (isRight == true && state == true){
    setDeviceValue(true, deviceIDRight[index]);
  }
  else if (isRight == true && state == false){
    setDeviceValue(false, deviceIDRight[index]);
  }
}
setButtonState(int index, bool isRight){
  if(isRight == true){
    getDeviceVal(deviceIDRight[index]).then((val){
      buttonState = val;
    });
  }
  else{
    int id = deviceIDLeft[index];
    getDeviceVal(73).then((val){
      buttonState = val;
    });
  }
}

isBlinder(int index, bool isRight){
  if (isRight == true && deviceInfoRight[0][index] == "blinder" || isRight == false && deviceInfoLeft[0][index] == "blinder"){
    milliStart = milliStart + 100;
    milliEnd = milliEnd + 100;
    return CustomSwitchVertical(
      height: 42,
      width: 24,
      borderRadius: 4,
      value: false,
      textSize: 0,
      colorOn: Colors.green,
      colorOff: primaryColor,
      animationDuration: Duration(milliseconds: 200),
      onChanged: (bool state) {
        setButtonState(index, isRight);
        switchButtonOnChanged(index,state, isRight);
      },
    );
  }
  else{
    milliStart = milliStart + 100;
    milliEnd = milliEnd + 100;
    return CustomSwitchHorizontal(
      height: 24,
      width: 42,
      borderRadius: 4,
      value: false,
      textSize: 0,
      colorOn: Colors.green,
      colorOff: primaryColor,
      iconSize: 0,
      iconOn: Icons.done,
      iconOff: Icons.remove_circle_outline,
      animationDuration: Duration(milliseconds: 200),
      onChanged: (bool state) {
        setButtonState(index, isRight);
        switchButtonOnChanged(index,state, isRight);
      },
    );
  }
}

class DeviceWidgetsRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: deviceIDRight.length,
      itemBuilder: (BuildContext context, int index){
        return Villain(
          villainAnimation: VillainAnimation.fromRight(
            from: Duration(milliseconds: milliStart),
            to: Duration(milliseconds: milliEnd),
            curve: animationCurve
          ),
          animateExit: false,
          secondaryVillainAnimation: VillainAnimation.fade(),
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 8),
                  child: Image(
                    image: AssetImage(deviceInfoRight[3][index]),
                    height: 32,
                    color: Colors.white,
                  )
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(deviceInfoRight[2][index], style: H3),
                        ),
                        Container(
                          margin: EdgeInsets.only(),
                          child: Text(deviceInfoRight[0][index], style: H4G),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: isBlinder(index, true)
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
class DeviceWidgetsLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: deviceIDLeft.length,
      itemBuilder: (BuildContext context, int index){
        return Villain(
          villainAnimation: VillainAnimation.fromLeft(
              from: Duration(milliseconds: milliStart),
              to: Duration(milliseconds: milliEnd),
              curve: animationCurve
          ),
          animateExit: false,
          secondaryVillainAnimation: VillainAnimation.fade(),
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Image(
                    image: AssetImage(deviceInfoLeft[3][index]),
                    height: 32,
                    color: Colors.white,
                  )
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(deviceInfoLeft[2][index], style: H3),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(deviceInfoLeft[0][index], style: H4G),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: isBlinder(index, false)
                )
              ],
            ),
          ),
        );
      }
    );
  }
}