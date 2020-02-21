import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/time.dart';
import 'package:mysql1/mysql1.dart';

//#region Variables
final List<int> deviceIDRight = <int>[];
final List<int> deviceIDLeft = <int>[];
final List<List<String>> deviceInfoRight = [
  [], // Type
  [], // Room
  [], // Name
  []  // Image
];
final List<List<String>> deviceInfoLeft = [
  [], // Type
  [], // Room
  [], // Name
  []  // Image
];
final List<int> deviceIDs = <int>[];
List<dynamic> sensorData = []; // Pressure | Temp | Hum
int deviceCount;
//#endregion

mainRequest(){
  getDeviceInformation();
  getSensorData();
}

void getDeviceCount()async{
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceCount = await conn.query('SELECT COUNT(id) FROM devices');
  for (var row in getDeviceCount) {
    deviceCount = row[0];
  }
}

Future<int> getDeviceMaxID()async{
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceCount = await conn.query('SELECT MAX(id) FROM devices');
  for (var row in getDeviceCount) {
    return row[0];
  }
}

Future<bool> getDeviceIDs()async{
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceIDs = await conn.query('SELECT id FROM devices');
  for (var row in getDeviceIDs) {
    deviceIDs.add(row[0]);
  }
  return true;
}

Future<bool> getDeviceInformation()async{
  var conn = await MySqlConnection.connect(connSettings);
  for(var i = 0; i<deviceIDs.length; i++){
    var result = await conn.query('SELECT * FROM devices WHERE id= ?', [deviceIDs[i]]);
    if (i%2 != 0){
      for (var row in result){
        deviceIDRight.add(row[0]);
        deviceInfoRight[0].add(row[1]);
        deviceInfoRight[1].add(row[2]);
        deviceInfoRight[2].add(row[5]);

        switch(row[1]){
          case "socket":
            break;
          case "switch":
            break;
          case "blinder":
            deviceInfoRight[3].add("lib/assets/shutter.png");
            break;
          case "light":
            deviceInfoRight[3].add("lib/assets/lightbulb.png");
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
    else{
      for (var row in result) {
        deviceIDLeft.add(row[0]);
        deviceInfoLeft[0].add(row[1]);
        deviceInfoLeft[1].add(row[2]);
        deviceInfoLeft[2].add(row[5]);

        switch(row[1]){
          case "socket":
            break;
          case "switch":
            break;
          case "blinder":
            deviceInfoLeft[3].add("lib/assets/shutter.png");
            break;
          case "light":
            deviceInfoLeft[3].add("lib/assets/lightbulb.png");
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
  return true;
}

Future<bool> getDeviceVal(int id)async{
  String query = "SELECT val FROM devices WHERE id = " + id.toString();
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceVal = await conn.query(query);
  for (var row in getDeviceVal) {
    if (row[0] == 0){
      return false;
    }
    else{
      return true;
    }
  }
}

Future<bool> getSensorData()async{
  var conn = await MySqlConnection.connect(connSettings);
  var query = "SELECT AVG(pressure), AVG(temperature), AVG(humidity) FROM data WHERE datetime > '" + getTimeNowQuery() +"'";
  var getData = await conn.query(query);
  if (getData.isNotEmpty){
    sensorData = getData.first.values;
    if (sensorData[0] == null){
      sensorData[0] = 0;
      sensorData[1] = 0;
      sensorData[2] = 0;
    }
    return true;
  }
  return false;
}

bool getGatewayStatus(){
  var conn = MySqlConnection.connect(connSettings);
  if (conn == null){
    // inactive
    return false;
  }
  else{
    // active
    return true;
  }
}

getRooms(){
  // TODO get rooms from mysql
}