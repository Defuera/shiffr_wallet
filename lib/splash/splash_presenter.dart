import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:shiffr_wallet/login/login_page.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class SplashPresenter {
  final _preferences = Preferences();

  void start(BuildContext context) {
    navigate(context);
  }

  void navigate(BuildContext context) async {
    var loggedIn = await isLoggedIn();
    await Future.delayed(Duration(milliseconds: 400));

//    if (loggedIn) {
      navigateTo(context, WalletsListPage());
//    } else {
//      navigateTo(context, LoginPage());
//    }
  }

  navigateTo(BuildContext context, Widget page) => Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => page),
      );

  Future<bool> isLoggedIn() async {
    var credentials = await _preferences.getCredentials();
    final loggedIn = credentials != null;
    return loggedIn;
  }
}
