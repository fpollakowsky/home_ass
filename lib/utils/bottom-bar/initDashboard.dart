import 'package:home_ass/utils/mysql/initMySQL.dart';

getWidgetsData()async{
  var conn = connectMySQL();
  var result = await conn.query('SELECT * FROM  WHERE id=') ;
  for (var row in result) {
    print('content: ${row[0]}, idFrom: ${row[1]}, idTo: ${row[2]}, type: ${row[3]}, timestamp: ${row[4]}');
  }
  await conn.close();
}