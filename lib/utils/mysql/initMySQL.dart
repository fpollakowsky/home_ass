import 'package:mysql1/mysql1.dart';

connectMySQL()async{
  var settings = ConnectionSettings(
      host: "85.214.233.67",
      port: 3306,
      user: "ehc_test",
      password: "rh2O@4a9",
      db: "ehc_test"
  );
  return await MySqlConnection.connect(settings);
}