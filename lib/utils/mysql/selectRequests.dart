import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/time.dart';

Future<dynamic> getDeviceInformation()async{
  var conn = await getMySQLConnection();
  return await conn.query('SELECT id,type,thing_name,val,isFavouriteBy,room,channel_name FROM devices ORDER BY isFavouriteBy DESC');
}

Future<dynamic> getRoomInformation()async{
  var conn = await getMySQLConnection();
  return await conn.query("SELECT name,image,device_count FROM rooms");
}

Future<dynamic> getRoutinesInformation()async{
  var conn = await getMySQLConnection();
  return await conn.query("SELECT title,weekdays,DATE_FORMAT(startTime, '%H:%i'),DATE_FORMAT(endTime, '%H:%i'),id,isActive Time FROM routines");
}

Future<dynamic> getSensorData()async{
  var conn = await getMySQLConnection(1); // Parameter for other db
  var result = await conn.query("SELECT table_name FROM information_schema.tables WHERE table_schema = 'data' LIMIT 1");
  var query = "SELECT AVG(pressure), AVG(temperature), AVG(humidity) FROM " + result.first.values[0] + " WHERE datetime > '" + getTimeNowQuery() +"'";
  return await conn.query(query);
}

Future<bool> getGatewayStatus()async{
  var conn = await getMySQLConnection();
  if (conn == null){
    return false; // inactive
  }
  else{
    return true; // active
  }
}