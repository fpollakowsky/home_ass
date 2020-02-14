import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:home_ass/utils/ui-elements/custom_buttons.dart';

final List<String> entries = <String>['Gadget 1','Gadget 2','Gadget 3','Gadget 4'];

class AllLights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child:Container(
                    child: Text(
                      entries[index],
                      style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      ),
                    )
                ),
              ),
              CustomSwitchButton_1(
                height: 40,
                width: 112,
                borderRadius: 4,
                value: true,
                colorOn: primaryColor,
                colorOff: Colors.green,
                iconOn: Icons.done,
                iconOff: Icons.remove_circle_outline,
                textSize: 16,
                offset: 48,
                onChanged: (bool state) {

                },
              ),
            ],
          )
        );
      },
    );
  }
}