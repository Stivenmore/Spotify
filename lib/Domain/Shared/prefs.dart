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

  // set to token app and save
  set token(String value) {
    _prefs!.setString('token', value);
  }

  // get token
  String get token {
    return _prefs!.getString('token') ?? '';
  }

  //set expire token duration seconds
  set expirestoken(int value) {
    _prefs!.setInt('expirestoken', value);
  }

  // get expire token
  int get expirestoken {
    return _prefs!.getInt('expirestoken') ?? 0;
  }

  set primary(bool value) {
    _prefs!.setBool('primary', value);
  }

  bool get primary {
    return _prefs!.getBool('primary') ?? true;
  }

  set oatoken(String value) {
    _prefs!.setString('oatoken', value);
  }

  String get oatoken {
    return _prefs!.getString('oatoken') ?? '';
  }
}
