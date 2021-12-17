

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

  static Future<bool> saveTheme(String theme) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString("theme");
    return theme;
  }
}