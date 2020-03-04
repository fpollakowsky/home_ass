import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/components/custom_buttons.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';

List<SingleRoutine> choices = <SingleRoutine>[
  SingleRoutine(title: 'All'),
  SingleRoutine(title: 'Today'),
];

class SingleRoutine extends StatefulWidget{
  SingleRoutine({this.title});

  final String title;

  @override
  _SingleRoutineState createState() => _SingleRoutineState();
}

class _SingleRoutineState extends State<SingleRoutine>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: routineList.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleRoutineWidget(
          title: routineList[index]['Title'],
          start: routineList[index]['Time'],
          weekdays: routineList[index]['Weekdays'],
          id: routineList[index]['ID'],
          value: routineList[index]['isActive'],
          index: index,
          tabTitle: widget.title,
        );
      }
    );
  }
}

// ignore: must_be_immutable
class SingleRoutineWidget extends StatelessWidget{
  final title;
  final start;
  final weekdays;
  final value;
  final id;
  final tabTitle;
  final index;
  String itemDate;

  SingleRoutineWidget({Key key, this.title, this.start, this.weekdays, this.itemDate, this.tabTitle, this.id, this.value, this.index}) : super(key: key);

  setItemDate(){
    for (var i=0; i < weekdays.length; i++){
      if(weekdays[i] == "1"){
        switch(i){
          case 0:
            if(itemDate != null){
              itemDate = itemDate + ", Monday";
            }
            else{
              itemDate = "Monday";
            }
            break;
          case 1:
            if(itemDate != null){
              itemDate = itemDate + ", Tuesday";
            }
            else{
              itemDate = "Tuesday";
            }
            break;
          case 2:
            if(itemDate != null){
              itemDate = itemDate + ", Wednesday";
            }
            else{
              itemDate = "Wednesday";
            }
            break;
          case 3:
            if(itemDate != null){
              itemDate = itemDate + ", Thursday";
            }
            else{
              itemDate = "Thursday";
            }
            break;
          case 4:
            if(itemDate != null){
              itemDate = itemDate + ", Friday";
            }
            else{
              itemDate = "Friday";
            }
            break;
          case 5:
            if(itemDate != null){
              itemDate = itemDate + ", Saturday";
            }
            else{
              itemDate = "Saturday";
            }
            break;
          case 6:
            if(itemDate != null){
              itemDate = itemDate + ", Sunday";
            }
            else{
              itemDate = "Sunday";
            }
            break;
        }
      }
    }
  }
  buttonOnChanged(bool state){
    updateRoutineInformation("isActive", state, id);
    routineList[index]["isActive"] = boolToInt(state);
  }

  @override
  Widget build(BuildContext context) {
    setItemDate();
    if(tabTitle == "All"){
      return Container(
        margin: EdgeInsets.only(left: 8,right: 8,bottom: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 5.0, // has the effect of extending the shadow
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16))
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ),
                  ),
                  Container(
                    child: CustomSwitchHorizontal(
                      height: 32,
                      width: 72,
                      borderRadius: 24,
                      value: intToBool(value),
                      colorOn: Colors.green,
                      colorOff: primaryColor,
                      iconOn: Icons.done,
                      iconOff: Icons.remove_circle_outline,
                      textSize: 16,
                      onChanged: buttonOnChanged
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Image(image: AssetImage("images/clock.png"),height: 24,color: primaryColor),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: Text(
                                    start,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, right: 16),
                            child: Row(
                              children: <Widget>[
                                Image(image: AssetImage("images/calendar.png"),height: 24,color: primaryColor),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      itemDate,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                  Text(
                    "x" + " devices",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Material(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Container(
                            height: 32,
                            width: 32,
                            child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.white,),
                          )
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
    else{
      print(weekdays[DateTime.now().weekday]);
      if(weekdays[DateTime.now().weekday - 1] == "1"){
        return Container(
          margin: EdgeInsets.only(left: 8,right: 8,bottom: 16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                          )
                      ),
                    ),
                    Container(
                      child: CustomSwitchHorizontal(
                          height: 32,
                          width: 72,
                          borderRadius: 24,
                          value: intToBool(value),
                          colorOn: Colors.green,
                          colorOff: primaryColor,
                          iconOn: Icons.done,
                          iconOff: Icons.remove_circle_outline,
                          textSize: 16,
                          onChanged: buttonOnChanged
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Image(image: AssetImage("images/clock.png"),height: 24,color: primaryColor),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      start,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8, right: 16),
                              child: Row(
                                children: <Widget>[
                                  Image(image: AssetImage("images/calendar.png"),height: 24,color: primaryColor),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        itemDate,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    Text(
                      "x" + " devices",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Material(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              height: 32,
                              width: 32,
                              child: Icon(Icons.arrow_forward_ios,size: 16,color: Colors.white,),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
      else{
        return Container(

        );
      }
    }
  }
}