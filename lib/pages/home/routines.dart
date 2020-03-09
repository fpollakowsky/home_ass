import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_ass/components/singleRoutine.dart';
import 'package:home_ass/pages/home/dashboard_1.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/res/global.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:home_ass/pages/add/addRoutine.dart';

class Routines extends StatefulWidget {
  @override
  _RoutinesState createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines>
    with SingleTickerProviderStateMixin {
  TabController _tabControllerRoutine;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setRoutinesInformation();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return FutureBuilder(
      future: setRoutinesInformation(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: Container(
            color: themeColor,
            child: DefaultTabController(
              length: choices.length,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 8,left: 8, right: 8),
                      color: secondaryColor,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Routines",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      letterSpacing: 2
                                  ),
                                ),
                              ),
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("images/male_profile.png"))
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TabBar(
                                    controller: _tabControllerRoutine,
                                    isScrollable: true,
                                    indicatorColor: Colors.transparent,
                                    tabs: choices.map((SingleRoutine choice) {
                                      return Tab(
                                        text: choice.title,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white
                                    ),
                                    onPressed: (){
                                      Navigator.of(context).push(PageTransition(type: PageTransitionType.transferRight, child: AddRoutine(), duration: Duration(milliseconds: 400)));
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: choices.map((SingleRoutine choice) {
                          return Container(
                            padding: EdgeInsets.only(top: 8),
                            child: SingleRoutine(title: choice.title),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}