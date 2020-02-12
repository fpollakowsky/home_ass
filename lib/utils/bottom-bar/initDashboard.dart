import 'package:home_ass/utils/mysql/initMySQL.dart';

getWidgetsData(int id)async{
  var conn = connectMySQL();
  var result = await conn.query('SELECT * FROM widgets WHERE id= ?', [id]) ;
  for (var row in result) {
    var id= row[0];
    var name= row[1];
    var icon= row[2];
    var devices= row[3];
  }
  await conn.close();
}