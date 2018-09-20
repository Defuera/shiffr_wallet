import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/overview/page_overview.dart';
import 'package:shiffr_wallet/wallets_list/page_wallets_list.dart';

import 'presenter_login.dart';

class LoginPage extends StatelessWidget {
  final _apiKeyController = TextEditingController();
  final _apiSecretController = TextEditingController();

  LoginPresenter _presenter;

 @override
  StatelessElement createElement() {
   _presenter = LoginPresenter(this);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(children: <Widget>[
                  TextField(
                    controller: _apiKeyController,
                    decoration: InputDecoration(
                      labelText: "Api key",
                    ),
                  ),
                  TextField(
                    controller: _apiSecretController,
                    decoration: InputDecoration(labelText: "Api secret"),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16.0)),
                  GestureDetector(
                    child: RaisedButton(
                      child: Text("Login"),
                      onPressed: () => _presenter.onLoginPressed(context, _apiKeyController.text, _apiSecretController.text),
                    ),
                    onLongPress: () => print("long pressed"),
                  ),
//                    RaisedButton(
//                      child: Text("Save data"),
//                      onPressed: () => _presenter.onLoginPressed(),
//                    ),
//                    Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                    RaisedButton(
//                      child: Text("Load data"),
//                      onPressed: () => _presenter.loadData()
//                    ),
                  Padding(padding: EdgeInsets.only(top: 54.0)),
                  FlatButton(
//              onPressed: _presenter.proceedWithoutLogin(),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      //todo should be at the bottom of the screen
                      child: RichText(
                        text: TextSpan(
                            text: "Proceed without loginnnn",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    onPressed: () => navigateTo(context, OverviewPage()),
                  ),
                ]))),
      );

  Future navigateTo(BuildContext context, Widget page) => Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => page),
    );


  void showWalletsPage(BuildContext context, List<Wallet> wallets) {
    navigateTo(context, WalletsListPage(wallets));
  }

  void showLoading(BuildContext context, bool show) {
    if (show){
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Center(child: CircularProgressIndicator())
      );
    } else {
      Navigator.pop(context);
    }
  }

}
