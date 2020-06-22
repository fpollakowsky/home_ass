import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/components/custom_buttons.dart';
import 'package:home_ass/utils/mqtt/mqtt_client_publish.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

// ignore: must_be_immutable
class SingleDevice extends StatefulWidget{
  @required
  String roomName;

  SingleDevice(
    {
    this.roomName
    });

  @override
  _SingleDeviceState createState() => _SingleDeviceState();
}

class _SingleDeviceState extends State<SingleDevice>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allDevices2.length,
      /*
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 8)),

       */
      itemBuilder: (BuildContext context, int index) {
        if (allDevices2[index]["Room"]!=widget.roomName){
          return Container();
        }
        else{
          if (allDevices2[index]["Type"]=="light" || allDevices2[index]["Type"]=="switch" || allDevices2[index]["Type"]=="socket" ){
            return SingleWidgetSwitch(
              name: allDevices2[index]["Name"],
              picture: allDevices2[index]["Image"],
              index: index,
            );
          }
          else{
            return SingleWidgetBlinder(
              name: allDevices2[index]["Name"],
              picture: allDevices2[index]["Image"],
              index: index,
            );
          }
        }
      }
    );
  }
}

class SingleWidgetSwitch extends StatelessWidget{
  final name;
  final picture;
  final index;

  const SingleWidgetSwitch({Key key, this.name, this.picture, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool val;
    String message;

    switch (allDevices2[index]['Value']){
      case 0:
        val=false;
        break;
      case 1:
        val=true;
        break;
      default:
        val=allDevices2[index]['Value'];
        break;
    }

    return  Hero(
        tag: name,
        child: Container(
          //height: 64,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  1, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  height: 48,
                  child: Image.asset(picture,color: primaryColor,),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: CustomSwitchHorizontal(
                    height: 32,
                    width: 72,
                    borderRadius: 4,
                    value: val,
                    colorOn: Colors.green,
                    colorOff: primaryColor,
                    iconOn: Icons.done,
                    iconOff: Icons.remove_circle_outline,
                    onChanged: (bool state) {
                      state  == true ? message = "on" : message = "off";                                // sets message variable value
                      val == true ? val = false : val = true;                                           // sets status value for (local&external) DB
                      DEBUG ?? print("MQTT:: Message: $message");
                      publishMQTT(allDevices2[index]["Channel"], allDevices2[index]["Room"], message);  // calls mqtt send method
                      updateDeviceInformation("val", val, allDevices2[index]["ID"]);                    // calls db update method
                      allDevices2[index]["Value"]=val;                                                  // sets local db value
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

class SingleWidgetBlinder extends StatefulWidget{
  final name;
  final picture;
  final index;

  const SingleWidgetBlinder({Key key, this.name, this.picture, this.index}) : super(key: key);

  @override
  SingleWidgetBlinderState createState() => SingleWidgetBlinderState(name,picture,index);
}


class SingleWidgetBlinderState extends State<SingleWidgetBlinder>{
  final name;
  final picture;
  final index;

  SingleWidgetBlinderState(this.name, this.picture, this.index);
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    bool val;
    switch (allDevices2[index]['Value']){
      case 0:
        val=false;
        break;
      case 1:
        val=true;
        break;
      default:
        val=allDevices2[index]['Value'];
        break;
    }

    return  Hero(
        tag: name,
        child: Container(
          height: 80,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  1, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: 48,
                  child: Image.asset(picture,color: primaryColor,),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            name,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,

                          /// TODO FRAMEWORK BUG 03.06.2020
                          /// Slider does not trigger properly
                          /// It triggers twice with onChangeEnd function

                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: primaryColor,
                              inactiveTrackColor: Colors.red[100],
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 6,
                              thumbColor: primaryColor,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                              overlayColor: Colors.red.withAlpha(32),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 24),
                            ),
                            child: Slider(
                              divisions: 10,
                              value: _value,
                              onChanged: (value) {
                                _value = value;
                                setState(() {});
                              },
                              onChangeEnd: (value){
                                /// DO NOT CHANGE
                                print(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        )
    );
  }
}