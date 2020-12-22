import 'package:shared_preferences/shared_preferences.dart';

void SetStringToSP (key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(key);
  print(value);
  prefs.setString(key, value);
}

GetStringToSP (key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString(key);
  print(key);
  print(stringValue);
  return stringValue;
}