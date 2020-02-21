import 'package:intl/intl.dart';

String getTimeNowQuery(){
  var date = DateFormat('yyyy-MM-dd');
  var timeH = DateFormat('HH');
  var timeM = DateFormat('mm');
  String datetime;
  String formattedYear = date.format(DateTime.now());
  int formattedH = int.parse(timeH.format(DateTime.now()));
  int formattedM = int.parse(timeM.format(DateTime.now()));

  if (formattedM < 5){
    formattedH = formattedH - 1;
    formattedM = 55;
  }
  else{
    formattedM = formattedM - 5;
  }

  if (formattedM < 10){
    datetime = formattedYear + " " + formattedH.toString() + ":0" + formattedM.toString();
  }
  else{
    datetime = formattedYear + " " + formattedH.toString() + ":" + formattedM.toString();
  }
  return datetime;
}