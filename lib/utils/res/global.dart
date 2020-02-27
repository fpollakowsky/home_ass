import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_ass/pages/home.dart';
import 'package:home_ass/pages/onBoard/first.dart';
import 'package:home_ass/utils/mysql/getRequests.dart';
import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/res/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool valFirstStart;
bool valNotification;
bool valDarkMode;
bool valFingerprint;

String valAbode;
String valName;
String valNick;
String valLanguage;
String valIP;
String valPrivacy;

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
final List<List<dynamic>> rooms = [
  [], // Name
  [], // Image
  []  // Device count
];

initFirstSetup(){
  setValueSharedPref("notification",false,"bool");
  setValueSharedPref("darkmode",true,"bool");
  setValueSharedPref("fingerprint",false,"bool");

  setValueSharedPref("abode","Living Room","string");
  setValueSharedPref("name","Unknown","string");
  setValueSharedPref("nickname","Unknown","string");
  setValueSharedPref("language","English","string");
  setValueSharedPref("privacy","Advanced","string");
}

initDashboard(context, bool isStartup){
  getConnection().then((val){
    if (val != "err"){
      setSensorData().then((val){
        setDeviceInformation().then((val){
          setRoomNames().then((val){
            setThemeMode();
            if (isStartup == true){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(index: 0,)));
            }
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
// //firstStart | notification | darkmode | fingerprint | abode | language | name | nickname | password | ip | privacy
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
}

setDeviceInformation()async{
  var result = await getDeviceInformation();
  for (var row in result){
    if (row != null){
      allDevices[0].add(row[0]);
      allDevices[2].add(row[1]);
      allDevices[3].add(row[2]);
      allDevices[5].add(row[3]);
      allDevices[1].add(row[4]);

      switch(row[1]){
        case "socket":
          break;
        case "switch":
          break;
        case "blinder":
          allDevices[4].add("lib/assets/shutter.png");
          break;
        case "light":
          allDevices[4].add("lib/assets/lightbulb.png");
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
  }
}

setSensorData()async{
  var result = await getSensorData();
  if (result.isNotEmpty){
    sensorData = result.first.values;
    if (sensorData[0] == null){
      sensorData[0] = 0;
      sensorData[1] = 0;
      sensorData[2] = 0;
    }
  }
}

setRoomNames()async{
  var result = await getRoomNames();
  for (var row in result) {
    rooms[0].add(row[0]);
    rooms[0].add(row[1]);
    rooms[0].add(row[2]);
  }
}

setThemeMode(){
  if (valDarkMode == true){
    themeColor = Color(0xff091C27);
    labelColor = Colors.white;
  }
  else{
    themeColor = Color(0xfff5f5f5);
    labelColor = Colors.black;
  }
}