import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/common/preferences.dart';
import 'package:shiffr_wallet/login/login_page.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class SplashPresenter {
  final _preferences = Preferences();

  void start(BuildContext context) {
    _navigate(context);
  }

  void _navigate(BuildContext context) async {
    var loggedIn = await _isLoggedIn();
    await Future.delayed(Duration(milliseconds: 200));

    if (loggedIn) {
      navigateAsNewRoot(context, WalletsListPage());
    } else {
      navigateTo(context, LoginPage());
    }
  }

  Future<bool> _isLoggedIn() async {
    var credentials = await _preferences.getCredentials();
    final loggedIn = credentials != null;
    return loggedIn;
  }
}
