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
splitTimestamp(timestamp){
  var timestamp1 = timestamp.split(RegExp(' '));
  var timestamp2 = timestamp1[1].split(RegExp('\\.'));
  var timestamp3 = timestamp2[0].split(RegExp('\\:'));
  return timestamp3[0]+':'+timestamp3[1];
}
String getTimeNow(int format, DateTime now){
  // 1: Full
  // 2: Day Month Year
  // 3: Day Month
  // 4: Month
  // 5: Hour:Minute

  String formattedDate;
  switch(format){
    case 1:
      return now.toString();
      break;
    case 2:
      formattedDate = DateFormat('d MMM y').format(now);
      return formattedDate.toString();
      break;
    case 3:
      formattedDate = DateFormat('d MMM').format(now);
      return formattedDate.toString();
      break;
    case 4:
      formattedDate = DateFormat('MM').format(now);
      return formattedDate.toString();
      break;
    case 5:
      formattedDate = DateFormat('kk:mm').format(now);
      return formattedDate.toString();
      break;
    default:
      return 'Something went wrong';
  }
}
