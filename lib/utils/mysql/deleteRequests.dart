import 'package:home_ass/utils/mysql/initMySQL.dart';

Future<dynamic> deleteRoutine(int id)async{
  var conn = await getMySQLConnection();
  return await conn.query("DELETE FROM routines WHERE id = ?", [id]);
}