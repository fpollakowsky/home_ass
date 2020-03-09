import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/components/custom_buttons.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

List<List<dynamic>> addDeviceList = [
  []
];

class SingleRoutineAddedDevice extends StatefulWidget{
  @override
  _SingleRoutineAddedDeviceState createState() => _SingleRoutineAddedDeviceState();
}

class _SingleRoutineAddedDeviceState extends State<SingleRoutineAddedDevice>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addRoutineDevice.length,
      itemBuilder: (BuildContext context, int index) {
        final item = addRoutineDevice[index]["Name"];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction){
            setState(() {
              addRoutineDevice.removeAt(index);
            });
          },
          child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        addRoutineDevice[index]["Name"],
                        style: TextStyle(
                            color: labelColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                  CustomSwitchHorizontal(
                    height: 32,
                    width: 80,
                    borderRadius: 4,
                    value: true,
                    colorOn: primaryColor,
                    colorOff: Colors.green,
                    iconOn: Icons.done,
                    iconOff: Icons.remove_circle_outline,
                    textSize: 16,
                    onChanged: (bool state) {
                      var deviceID = addRoutineDevice[index]["ID"];
                      var deviceName = addRoutineDevice[index]["Name"];
                      addRoutineDevice.removeAt(index);
                      addRoutineDevice.insert(index,{
                        "ID": deviceID,
                        "Name": deviceName,
                        "Value": boolToInt(state)
                      });
                    },
                  ),
                ],
              )
          ),
        );
      }
    );
  }
}