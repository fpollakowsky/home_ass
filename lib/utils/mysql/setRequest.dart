import 'package:home_ass/utils/mysql/initMySQL.dart';
import 'package:mysql1/mysql1.dart';

setDeviceValue(val, id)async{
  var conn = await MySqlConnection.connect(connSettings);
  await conn.query('UPDATE devices SET val = ? WHERE id = ?', [val, id]);
}