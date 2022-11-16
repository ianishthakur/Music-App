import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
 static setUserLoggedIn(bool value) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.setBool("IsUserLoggedIn", value);
  }

  static Future<bool> getIsUserLoggedIn() async {
    final _instance = await SharedPreferences.getInstance();
    final value = _instance.getBool("IsUserLoggedIn");
    if (value == null) {
      return false;
    }
    return value;
  }
}
