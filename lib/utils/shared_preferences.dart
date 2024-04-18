import 'package:shared_preferences/shared_preferences.dart';

const String firstTime = 'first_time';
const String uName = 'user_name';

class MySharedPrefrence {
  static final MySharedPrefrence _mySharedPrefrence =
      MySharedPrefrence._internal();

  MySharedPrefrence._internal();

  factory MySharedPrefrence() {
    return _mySharedPrefrence;
  }

  Future<void> setOldUser(bool firstime) async {
    final myPrefs = await SharedPreferences.getInstance();
    await myPrefs.setBool(firstTime, firstime);
  }

  Future<bool> oldUser() async {
    final myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(firstTime) ?? false;
  }

  Future<void> setUser(String name) async {
    final myPrefs = await SharedPreferences.getInstance();
    await myPrefs.setString(uName, name);
  }

  Future<String> getUser() async {
    final myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(uName) ?? "";
  }
}
