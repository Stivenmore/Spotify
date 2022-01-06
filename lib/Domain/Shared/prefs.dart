import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // logout to app
  logout() {
    _prefs!.remove('token');
  }

  // set to locale app and save
  set locale(String value) {
    _prefs!.setString('locale', value);
  }

  // get token
  String get locale {
    return _prefs!.getString('locale') ?? 'AU';
  }

  //set expire token duration seconds
  set expirestoken(int value) {
    _prefs!.setInt('expirestoken', value);
  }

  // get expire token
  int get expirestoken {
    return _prefs!.getInt('expirestoken') ?? 0;
  }

  set oatoken(String value) {
    _prefs!.setString('oatoken', value);
  }

  String get oatoken {
    return _prefs!.getString('oatoken') ?? '';
  }
}
