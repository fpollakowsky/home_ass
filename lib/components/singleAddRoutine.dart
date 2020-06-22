import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/devices/DevicePage.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:home_ass/utils/res/global.dart';

// ignore_for_file: non_constant_identifier_names
class SingleAddRoutine extends StatefulWidget{
  @override
  _SingleAddRoutineState createState() => _SingleAddRoutineState();
}

class _SingleAddRoutineState extends State<SingleAddRoutine>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: allDevices2.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleWidget(
            name: allDevices2[index]["Name"],
            picture: allDevices2[index]["Image"],
          );
        }
    );
  }
}

class SingleWidget extends StatelessWidget{
  final name;
  final picture;

  const SingleWidget({Key key, this.name, this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color boxColor = Colors.white;
    return  Hero(
        tag: name,
        child: Container(
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
            color: boxColor,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                boxColor == Colors.white ? boxColor = Colors.grey : boxColor = Colors.white;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 64,
                    margin: EdgeInsets.only(top: 16),
                    child: Image.asset(picture,color: primaryColor,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}