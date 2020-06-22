import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/devices/DevicePage.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/transitions.dart';
import 'package:home_ass/utils/res/global.dart';

// ignore_for_file: non_constant_identifier_names
class SingleRoom extends StatefulWidget{
  @override
  _SingleRoomState createState() => _SingleRoomState();
}

class _SingleRoomState extends State<SingleRoom>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: roomList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SingleRoomWidget(
          room_name: roomList[index]['name'],
          room_picture: roomList[index]['picture'],
        );
      }
    );
  }
}

class SingleRoomWidget extends StatelessWidget{
  final room_name;
  final room_picture;

  const SingleRoomWidget({Key key, this.room_name, this.room_picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Hero(
      tag: room_name,
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
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            onTap: () => Navigator.of(context).push(FadeRouteBuilder(page: DevicesTab(roomName: room_name))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 64,
                  margin: EdgeInsets.only(top: 16),
                  child: Image.asset(room_picture,color: primaryColor),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    room_name,
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