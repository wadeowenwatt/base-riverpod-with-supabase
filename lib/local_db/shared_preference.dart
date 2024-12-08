import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constants/app_constants.dart';

class SharedPreference {
  static Future<void> setUDID(String udid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.udid, udid);
  }

  static Future<String?> getUDID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.udid);
  }

}
