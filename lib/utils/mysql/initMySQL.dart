import 'package:home_ass/utils/res/global.dart';
import 'package:mysql1/mysql1.dart';

Future<dynamic>getMySQLConnection([int database])async{
  var connSettings;
  int databasePort = 3306;
  String databaseSensor = "data";
  String databaseGeneral = "ehome-concepts";
  String databaseUser = "fpollakowsky";       // ehome-concepts
  String databasePassword = "2maL5UbXeUhG";   // rh2O@4a9

  /// DEBUG
  if (DEBUG == null){
    /// Disabled
    //valIP = "85.214.233.67";
    //String databaseUser = "ehome-concepts";
    //String databasePassword = "rh2O@4a9";
  }
  /// END

  if(database == 1){
    connSettings = ConnectionSettings(
        host: valIP,
        port: databasePort,
        user: databaseUser,
        password: databasePassword,
        db: databaseSensor
    );
  }else{
    connSettings = ConnectionSettings(
        host: valIP,
        port: databasePort,
        user: databaseUser,
        password: databasePassword,
        db: databaseGeneral
    );
  }

  try{
    var conn = await MySqlConnection.connect(connSettings).timeout(Duration(seconds: 5));
    return conn;
  }
  catch(e){
    DEBUG ?? print("MYSQL:: Connection failure! \nMYSQL:: $e");
    return "101";
  }
}