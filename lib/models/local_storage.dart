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

  static Future<bool> addFav(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites = sharedPreferences.getStringList("favourites") ?? [];
    favourites.add(id);
    return await sharedPreferences.setStringList("favourites", favourites);
  }

  static Future<bool> removeFav(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites = sharedPreferences.getStringList("favourites") ?? [];
    favourites.remove(id);
    return await sharedPreferences.setStringList("favourites", favourites);
  }

  static Future<List<String>> fetchFav() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites = sharedPreferences.getStringList("favourites") ?? [];
    return favourites;
  }

}