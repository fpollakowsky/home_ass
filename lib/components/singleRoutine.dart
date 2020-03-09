import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/components/custom_buttons.dart';
import 'package:home_ass/utils/mysql/deleteRequests.dart';
import 'package:home_ass/utils/mysql/updateRequest.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:home_ass/pages/home/routines.dart';

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
        var title = routineList[index]['Title'];
        var start = routineList[index]['Start'];
        var end = routineList[index]['End'];
        var weekdays = routineList[index]['Weekdays'];
        var id = routineList[index]['ID'];
        var value = routineList[index]['isActive'];
        var tabTitle = widget.title;
        var itemDate;

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
          if (itemDate == "Monday, Tuesday, Wednesday, Thursday, Friday"){
            itemDate = "On Weekdays";
          }else if (itemDate == "Saturday, Sunday"){
            itemDate = "On Weekends";
          }else if (itemDate == "Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday"){
            itemDate = "Every Day";
          }
        }
        buttonOnChanged(bool state){
          updateRoutineInformation("isActive", state, id);
          routineList[index]["isActive"] = boolToInt(state);
        }
        setItemDate();

        if(tabTitle == "All"){
          return Dismissible(
            direction: DismissDirection.startToEnd,
            key: Key(title),
            // ignore: missing_return
            confirmDismiss: (DismissDirection direction)async{
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: primaryColor,
                    title: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    content: Text(
                      "Are you sure you wish to delete this item?",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          "DELETE",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ).then((val){
                if(val == true){
                  deleteRoutine(routineList[index]['ID']);
                  routineList.removeAt(index);
                  setState(() {});
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
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
                                        start + "-" + end.toString(),
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
            )
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
                                          start + end,
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
    );
  }
}