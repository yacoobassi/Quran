import 'package:shared_preferences/shared_preferences.dart';

class helper {
  static String sharedLoggedKey = "ISLOGGEDIN";
  static String sharedNamekey = "USERNAMEKEY";
  static String sharedEmailkey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedLoggedKey, isLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedNamekey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedEmailkey, userEmail);
  }

  static Future<bool> getUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getBool(sharedLoggedKey);
  }

  static Future<String> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(sharedNamekey);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(sharedEmailkey);
  }
}
