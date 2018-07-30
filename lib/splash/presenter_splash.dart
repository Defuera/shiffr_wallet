import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:shiffr_wallet/login/page_login.dart';
import 'package:shiffr_wallet/splash/page_splash.dart';
import 'package:shiffr_wallet/wallets_list/page_wallets_list.dart';

class SplashPresenter {
  final _preferences = Preferences();

  final SplashPage _view;

  SplashPresenter(this._view);

  void start(BuildContext context) {
    if (isLoggedIn()) {
      navigateTo(context, WalletsListPage());
    } else {
      navigateTo(context, LoginPage());
    }
  }

  navigateTo(BuildContext context, Widget page) => Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => page),
      );

  bool isLoggedIn() => _preferences.getCredentials() != null;
}
