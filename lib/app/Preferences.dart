import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static const _PREF_KEY = 'key';
  static const _PREF_SECRET = 'secret';

  store(String key, String secret) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_KEY, key);
    await prefs.setString(_PREF_SECRET, secret);
  }


  Future<Tuple> get() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getString(_PREF_KEY);
    final secret = prefs.getString(_PREF_SECRET);

    return Tuple(key, secret);
  }

}

class Tuple {

  final String key;
  final String secret;

  Tuple(this.key, this.secret);
}
