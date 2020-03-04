import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:home_ass/pages/home/dashboard_1.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/utils/res/styles.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

bool buttonState = false;

class CreateDeviceWidgets extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    milliStart = 1100;
    milliEnd = 1800;
    return ListView.builder(
      itemCount: 4,
      // ignore: missing_return
      itemBuilder: (BuildContext context, int index){
        if(allDevices[1][index] == "fpollakowsky"){
          return Villain(
              villainAnimation: VillainAnimation.fromBottom(
                  relativeOffset: 0.4,
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
                          margin: EdgeInsets.only(left: 16),
                          child: Image(
                            image: AssetImage(allDevices[4][index]),
                            height: 32,
                            color: Colors.white,
                          )
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(allDevices[3][index], style: H3),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: Text(allDevices[2][index], style: H4G),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 16, top: 8, bottom: 8),
                          child: isBlinder(index, true)
                      )
                    ]
                ),
              )
          );
        }
      },
    );
  }

}

switchButtonOnChanged(int index, bool state, bool isRight){
  if (isRight == false && state == true){
    updateDeviceInformation("val", true, allDevices[0][index]);
  }
  else if(isRight == false && state == false){
    updateDeviceInformation("val", false, allDevices[0][index]);
  }
  else if (isRight == true && state == true){
    updateDeviceInformation("val", true, allDevices[0][index]);
  }
  else if (isRight == true && state == false){
    updateDeviceInformation("val", false, allDevices[0][index]);
  }
}

setButtonState(int index){
  if(allDevices[5][0] == 1){
    buttonState = true;
  }
  else{
    buttonState = false;
  }
}

isBlinder(int index, bool isRight){
  if (allDevices[2][index] == "blinder"){
    setAnimationTime();
    return CustomSwitchVertical(
      height: 58,
      width: 26,
      borderRadius: 4,
      value: buttonState,
      colorOn: Colors.green,
      colorOff: primaryColor,
      animationDuration: Duration(milliseconds: 200),
      onChanged: (bool state) {
        setButtonState(index);
        switchButtonOnChanged(index,state, isRight);
      },
    );
  }
  else{
    milliStart = milliStart + 100;
    milliEnd = milliEnd + 100;
    return CustomSwitchHorizontal(
      height: 32,
      width: 64,
      borderRadius: 4,
      value: buttonState,
      colorOn: Colors.green,
      colorOff: primaryColor,
      iconSize: 20,
      iconOn: Icons.done,
      iconOff: Icons.remove_circle_outline,
      animationDuration: Duration(milliseconds: 200),
      onChanged: (bool state) {
        setButtonState(index);
        switchButtonOnChanged(index,state, isRight);
      },
    );
  }
}