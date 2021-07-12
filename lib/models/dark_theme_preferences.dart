import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  static const theme_status="ThemeStatus";
// this method to store the theme status in the local storage 
  setDarkTheme (bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(theme_status, value);
  }
  //this method to get the theme status from the local storage
  Future<bool> getTheme () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // this ?? means if the condition is null return false and false means return the default theme which light theme
    return prefs.getBool(theme_status)?? false;

  }
}