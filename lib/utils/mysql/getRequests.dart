import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/time.dart';
import 'package:mysql1/mysql1.dart';

//#region Variables
List<List<dynamic>> allDevices = [
  [], // ID
  [], // Left / Right -> TODO DEPRECATED
  [], // Type
  [], // Name
  [], // Image
  []  // Value -> On / Off | 1 / 0
];

final List<List<void>> rooms = [
  [], // Name
  [], // Image
  []  // Device count
];
final List<int> deviceIDs = <int>[];
List<dynamic> sensorData = []; // Pressure | Temp | Hum
int deviceCount;
//#endregion

mainRequest(){
  getRoomNames();
}

// ignore: missing_return
Future<int> getDeviceMaxID()async{
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceCount = await conn.query('SELECT MAX(id) FROM devices');
  for (var row in getDeviceCount) {
    return row[0];
  }
}

Future<bool> getDeviceIDs()async{
  String query = "SELECT id FROM devices";
  var conn = await MySqlConnection.connect(connSettings);
  var getDeviceIDs = await conn.query(query);

  for (var row in getDeviceIDs) {
    deviceIDs.add(row[0]);
  }
  return true;
}

Future<bool> getDeviceInformation()async{
  var conn = await MySqlConnection.connect(connSettings);
  var result = await conn.query('SELECT id,type,thing_name,val,isFavouriteBy FROM devices ORDER BY isFavouriteBy DESC');
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
  return true;
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

Future<bool> getRoomNames()async{
  var conn = await MySqlConnection.connect(connSettings);
  var getRooms = await conn.query("SELECT name,image,device_count FROM rooms");
  for (var row in getRooms) {
    rooms[0].add(row[0]);
    rooms[0].add(row[1]);
    rooms[0].add(row[2]);
  }
  return true;
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