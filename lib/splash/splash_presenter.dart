import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:shiffr_wallet/login/login_page.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class SplashPresenter {
  final _preferences = Preferences();

  void start(BuildContext context) {
    _navigate(context);
  }

  void _navigate(BuildContext context) async {
    var loggedIn = await _isLoggedIn();
    await Future.delayed(Duration(milliseconds: 400));
//    Navigator.pop(context); //todo remove splash screen

    if (loggedIn) {
      _navigateTo(context, WalletsListPage());
    } else {
      _navigateTo(context, LoginPage());
    }
  }

  _navigateTo(BuildContext context, Widget page) => Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => page),
      );

  Future<bool> _isLoggedIn() async {
    var credentials = await _preferences.getCredentials();
    final loggedIn = credentials != null;
    return loggedIn;
  }
}
