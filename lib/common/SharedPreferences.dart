import 'package:shared_preferences/shared_preferences.dart';

void SetStringToSP (key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(key);
  print(value);
  prefs.setString(key, value);
}

Future<String> GetStringToSP(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString(key);
  return stringValue?? "";
}