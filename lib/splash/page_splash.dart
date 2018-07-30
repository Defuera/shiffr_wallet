import 'package:flutter/material.dart';

import 'presenter_splash.dart';

class SplashPage extends StatelessWidget {
  SplashPresenter _presenter;

  @override
  StatelessElement createElement() {
    _presenter = SplashPresenter(this);
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
//    _presenter.start(context);

    return Material(
        child: Container(
            color: Theme.of(context).accentColor,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Image.asset("assets/ic_logo.png"), //todo svg
              Padding(padding:  EdgeInsets.all(4.0)),
              Text(
                "Shiffr",
                style: TextStyle( //todo corporate font
                    fontSize: 54.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                ),
              )
//              SvgPicture.asset(
//                "assets/ic_logo2.svg",
//                width: 200.0,
//                height: 200.0,
//                color: Colors.white,
//              ),
            ])));
  }

}
