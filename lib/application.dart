import 'package:flutter/material.dart';
import 'package:shiffr_wallet/splash/splash_page.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SplashPage(),
    );
  }
}
