import 'package:flutter/material.dart';
import 'package:shop_app/models/dark_theme_preferences.dart';

class DarkThemeProvider extends ChangeNotifier{
  //here get object from DarkThemePreferences class
DarkThemePreferences darkThemePreferences=DarkThemePreferences();
  bool _darkTheme=false;
  bool get darkTheme=>_darkTheme;
 set darkTheme (bool value){
   _darkTheme=value;
   //here send the status to the DarkThemePreferences class to save it 
   darkThemePreferences.setDarkTheme(value);
   notifyListeners();
 }
}