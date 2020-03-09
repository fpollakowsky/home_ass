import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:mysql1/mysql1.dart';

updateDeviceInformation(key, val, id)async{
  var conn = await MySqlConnection.connect(connSettings);
  var query = "UPDATE routines SET " + key + " = " + val.toString() + " WHERE id = " + id.toString();
  await conn.query(query);
}

updateRoutineInformation(key,val, id)async{
  var conn = await MySqlConnection.connect(connSettings);
  var query = "UPDATE routines SET " + key + " = " + val.toString() + " WHERE id = " + id.toString();
  await conn.query(query);
}

insertRoutineInformation(title, weekdays, action, startTime, endTime)async{
  var conn = await MySqlConnection.connect(connSettings);
  await conn.query("INSERT INTO routines(title, weekdays, action, startTime, endTime) VALUES (?,?,?,?,?)",
  [title,weekdays,action,startTime,endTime]);
}