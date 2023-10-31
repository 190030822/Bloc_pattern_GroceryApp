import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {

  static late SharedPreferences _preferences;

  static const String _userkey = "username";
  static const String _password = "password";

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void setUserName(String name) {
    _preferences.setString(_userkey, name);
  }

  static void setPassword(String password) {
    _preferences.setString(_password, password);
  }

  static String? getUserName() {
    return _preferences.getString(_userkey);
  }

  static String? getPassword() {
    return _preferences.getString(_password);
  }
}