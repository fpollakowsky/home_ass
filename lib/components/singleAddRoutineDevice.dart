import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/global.dart';

class SingleAddRoutineDevice extends StatefulWidget{
  @override
  _SingleAddRoutineDeviceState createState() => _SingleAddRoutineDeviceState();
}

class _SingleAddRoutineDeviceState extends State<SingleAddRoutineDevice>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allDevices2.length,
      itemBuilder: (BuildContext context, int index) {
        return  Material(
          color: Colors.transparent,
          type: MaterialType.button,
          child: InkWell(
            onTap: (){
              addRoutineDevice.add({
                "ID": allDevices2[index]["ID"],
                "Name": allDevices2[index]["Name"],
                "Value": 1
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Text(
                allDevices2[index]["Name"],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
                textAlign: TextAlign.center,
              )
            ),
          ),
        );
      }
    );
  }
}