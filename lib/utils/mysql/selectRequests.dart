import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:home_ass/utils/time.dart';

Future<dynamic> getDeviceInformation()async{
  var conn = await getConnection();
  return await conn.query('SELECT id,type,thing_name,val,isFavouriteBy,room FROM devices ORDER BY isFavouriteBy DESC');
}

Future<dynamic> getRoomInformation()async{
  var conn = await getConnection();
  return await conn.query("SELECT name,image,device_count FROM rooms");
}

Future<dynamic> getRoutinesInformation()async{
  var conn = await getConnection();
  return await conn.query("SELECT title,weekdays,DATE_FORMAT(startTime, '%H:%i'),DATE_FORMAT(endTime, '%H:%i'),id,isActive Time FROM routines");
}

Future<dynamic> getSensorData()async{
  var conn = await getConnection();
  var query = "SELECT AVG(pressure), AVG(temperature), AVG(humidity) FROM data WHERE datetime > '" + getTimeNowQuery() +"'";
  return await conn.query(query);
}

Future<bool> getGatewayStatus()async{
  var conn = await getConnection();
  if (conn == null){
    return false; // inactive
  }
  else{
    return true; // active
  }
}