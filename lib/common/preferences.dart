import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const _PREF_KEY = 'key';
  static const _PREF_SECRET = 'secret';

  storeCredentials(String key, String secret) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_KEY, key);
    await prefs.setString(_PREF_SECRET, secret);
  }

  Future<Credentials> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getString(_PREF_KEY);
    final secret = prefs.getString(_PREF_SECRET);

    if (key == null || secret == null) {
      prefs.clear();
      return null;
    } else {
      return Credentials(key, secret);
    }
  }
}

class Credentials {
  final String key;
  final String secret;

  Credentials(this.key, this.secret);
}
