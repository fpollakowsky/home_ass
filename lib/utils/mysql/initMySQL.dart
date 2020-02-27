import 'package:home_ass/utils/res/global.dart';
import 'package:mysql1/mysql1.dart';

var connSettings = ConnectionSettings(
    //host: "85.214.233.67",
    host: valIP,
    port: 3306,
    user: "ehc_test",
    password: "rh2O@4a9",
    db: "ehc_test"
);

Future<dynamic>getConnection()async{
  try{
    var conn = await MySqlConnection.connect(connSettings).timeout(Duration(seconds: 5));
    return conn;
  }
  catch(e){
    return "err";
  }
}