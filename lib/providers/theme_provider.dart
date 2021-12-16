import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;
  
  ThemeProvider(String theme){
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    }else{
      themeMode = ThemeMode.dark;
    }
  }

  void toggleTheme(){
    if(themeMode == ThemeMode.light){
      themeMode = ThemeMode.dark;
    }else{
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}