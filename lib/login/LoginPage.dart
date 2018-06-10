import 'package:flutter/material.dart';
import 'package:shiffr_wallet/overview/OverviewPage.dart';

import 'LoginPresenter.dart';

class LoginPage extends StatelessWidget {
  final _apiKeyController = TextEditingController();
  final _apiSecretController = TextEditingController();
  final _presenter = LoginPresenter();

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
                      onPressed: () => _presenter.onLoginPressed(
                          _apiKeyController.text, _apiSecretController.text),
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
                    onPressed: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new OverviewPage()),
                      );
                    },
                  ),
                ]))),
      );
}
