import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:shiffr_wallet/login/page_login.dart';


class LoginPresenter {
  final _preferences = Preferences();
  final _api = BitfinexApiV2();

  final LoginPage _view;

  LoginPresenter(this._view);

  void onLoginPressed(BuildContext context, String key, String secret) async {
    print("onLoginPressed");
    _view.showLoading(context, true);

    try {
      _view.showLoading(context, false);

      final wallets = await _api.getWallets();
      print("get wallets success: $wallets");
      _preferences.store(key, secret);

      _view.showWalletsPage(context, wallets);
    } catch (exception, stacktrace) {
      _view.showLoading(context, false);
      print("exception: ${exception.toString()}");
      print(stacktrace.toString());
    }
  }

//
//  fetchPost() async {
//    final response = await get('https://jsonplaceholder.typicode.com/posts/1');
//    final responseJson = json.decode(response.body);
//
//    print("response: ${response.body}");
//    return Post.fromJson(responseJson);
//  }
//
//  void onData(Response event) {
//    print(event);
//  }
//
  proceedWithoutLogin() {}

  loadSavedCredentials() {
    loadData();
  }

  loadData() async {
    final tuple = await _preferences.get();
    final key = tuple.key;
    final secret = tuple.secret;

    print("load credentials: $key, $secret");
  }
}
