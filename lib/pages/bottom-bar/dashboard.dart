import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';

class DashboardIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Welcome home",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17
                        ),
                      ),
                      Text(
                        "Florian Pollakowsky",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
              )
            ],
          ),
          AnimatedContainer(
            duration: Duration(seconds: 2),
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              //color: primaryColor,
                border: Border.all(width: 2, color: primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 64,
                  width: 64,
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(Icons.power),
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "20,4" + "Kwh",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            "Power usage for today",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  child: IconButton(icon: Icon(Icons.keyboard_arrow_right, color: Colors.black,),), // TODO onPressed
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 32),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Material(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                        onTap: () => print("Container pressed"),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image(image: AssetImage("lib/assets/bathroom.png"),),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.only(top: 32),
                                                  child: Text(
                                                    "Bathroom",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "1 Device",
                                                style: TextStyle(
                                                    color: Colors.grey
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Material(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                        onTap: () => print("Container pressed"),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image(image: AssetImage("lib/assets/living-room.png"),color: Colors.white,),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.only(top: 32),
                                                  child: Text(
                                                    "Living Room",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "1 Device",
                                                style: TextStyle(
                                                    color: Colors.grey
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.only(right: 8),
                                  child: Material(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                        onTap: () => print("Container pressed"),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image(image: AssetImage("lib/assets/cooking.png"),color: Colors.white,),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.only(top: 32),
                                                  child: Text(
                                                    "Kitchen",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "1 Device",
                                                style: TextStyle(
                                                    color: Colors.grey
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  height: 150,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Material(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.all(Radius.circular(24)),
                                    child: InkWell(
                                        onTap: () => print("Container pressed"),
                                        borderRadius: BorderRadius.all(Radius.circular(24)),
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image(image: AssetImage("lib/assets/diningRoom.png"),color: Colors.white,),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.bottomLeft,
                                                  margin: EdgeInsets.only(top: 32),
                                                  child: Text(
                                                    "Dining Room",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "1 Device",
                                                style: TextStyle(
                                                    color: Colors.grey
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}