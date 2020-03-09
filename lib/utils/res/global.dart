import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/home.dart';
import 'package:home_ass/utils/mysql/selectRequests.dart';
import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool valFirstStart,valNotification,valDarkMode,valFingerprint;
String valAbode,valName,valNick,valLanguage,valIP,valPrivacy,valProfile,heroTagOnBoard;
List<String> gatewayIPs = [];
List<dynamic> sensorData = []; // Pressure | Temp | Hum
List<List<dynamic>> allDevices = [
  [], // ID
  [], // isFavouriteBy
  [], // Type
  [], // Name
  [], // Image
  []  // Value -> On / Off | 1 / 0
];
var allDevices2 = [];
var roomList = [];
var routineList = [];
var addRoutineDevice = [];

initFirstSetup(){
  setValueSharedPref("notification", false,"bool");
  setValueSharedPref("darkmode", false,"bool");
  setValueSharedPref("fingerprint", false,"bool");

  setValueSharedPref("abode","Living Room","string");
  setValueSharedPref("language","English","string");
  setValueSharedPref("privacy","Advanced","string");
}

initDashboard(context, bool isStartup){
  getConnection().then((val){
    if (val != "err"){
      setSensorData().then((val){
        setDeviceInformation().then((val){
          setRoomList().then((val){
            setThemeMode();
            setRoutinesInformation().then((val){
              if (isStartup == true){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(index: 0,)));
              }
            });
          });
        });
      });
    }
    else{
      if (isStartup == true){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(index: 0,)));
      }
    }
  });
}

// KEYS
// firstStart | notification | darkmode | fingerprint | abode | language | name | nickname | ip | privacy
setValueSharedPref(key, value, type)async{
  SharedPreferences sharedPref = await SharedPreferences.getInstance();

  if (type == "string"){
    await sharedPref.setString(key, value);
  }
  else{
    await sharedPref.setBool(key, value);
  }
}

getSettings(key, type)async{
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  if (type == "string"){
    return sharedPref.getString(key);
  }
  else{
    return sharedPref.getBool(key);
  }
}

loadProfilePicture()async{
  valProfile = await getSettings("profilePicture", "string");
}

loadSharedPreferences()async{
  valFirstStart = await getSettings("firstStart", "bool");
  valNotification = await getSettings("notification", "bool");
  valDarkMode = await getSettings("darkmode", "bool");
  valFingerprint = await getSettings("fingerprint", "bool");

  valAbode = await getSettings("abode", "string");
  valName = await getSettings("name", "string");
  valNick = await getSettings("nickname", "string");
  valLanguage = await getSettings("language", "string");
  valPrivacy = await getSettings("privacy", "string");
  valIP = await getSettings("ip", "string");
  valProfile = await getSettings("profilePicture", "string");
}

setDeviceInformation()async{
  var result = await getDeviceInformation();
  allDevices2.removeRange(0, allDevices2.length);

  for (var row in result){
    if (row != null){
      allDevices2.add({
        "ID": row[0],
        "Type": row[1],
        "Name": row[2],
        "Value": row[3],
        "isFavouriteBy": row[4],
        "Room": row[5],
        "Image": getDeviceImage(row)
      });
      allDevices[0].add(row[0]);
      allDevices[2].add(row[1]);
      allDevices[3].add(row[2]);
      allDevices[5].add(row[3]);
      allDevices[1].add(row[4]);
    }
  }
}

setRoutinesInformation()async{
  var result = await getRoutinesInformation();
  routineList.removeRange(0, routineList.length);

  for(var row in result){
    if(row != null){
      routineList.add({
        "Title": row[0].toString(),
        "Weekdays": json.decode(row[1].toString()),
        "Start": row[2],
        "End": row[3],
        "ID": row[4],
        "isActive": row[5],
      });
    }
  }
}

setSensorData()async{
  var result = await getSensorData();
  sensorData.removeRange(0, sensorData.length);

  if (result.isNotEmpty){
    sensorData = result.first.values;
    if (sensorData[0] == null){
      sensorData[0] = 0;
      sensorData[1] = 0;
      sensorData[2] = 0;
    }
  }
}

setRoomList()async{
  var result = await getRoomInformation();
  for (var row in result) {
    roomList.add({
      "name": row[0],
      "picture": row[1],
      "devices": row[2]
    });
  }
}

setThemeMode(){
  if (valDarkMode == true){
    themeColor = Color(0xff091C27);
    secondaryColor = themeColor;
    labelColor = Colors.white;
  }
  else{
    themeColor = Color(0xfff5f5f5);
    secondaryColor = Color(0xFFbf360c);
    labelColor = Colors.black54;
  }
}

setHeroTagOnBoard(String val){
  heroTagOnBoard = val;
}

String getDeviceImage(row){
  switch(row[1]){
    case "socket":
      break;
    case "switch":
      break;
    case "blinder":
      return "lib/assets/shutter.png";
      break;
    case "light":
      return "lib/assets/lightbulb.png";
      break;
    case "fridge":
      break;
    case "sensor_weather":
      break;
    case "thermostat":
      break;
    case "fan":
      break;
    case "speaker":
      break;
  }
}

bool intToBool(int i){
  if (i == 1){
    return true;
  }else{
    return false;
  }
}

int boolToInt(bool i){
  if (i == true){
    return 1;
  }else{
    return 0;
  }
}