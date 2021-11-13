
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getFormatedDate(num dt,String f){

  return DateFormat(f).format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()*1000));



}

Future<bool> setTempStatus(bool status)async{

 final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(status);

  return prefs.setBool("temp", status);


}

Future<bool> getTempStatus()async{

  final SharedPreferences prefs = await SharedPreferences.getInstance();


  return prefs.getBool("temp")??false;


}



