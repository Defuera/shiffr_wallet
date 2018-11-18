import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/app/colors.dart';
import 'package:shiffr_wallet/splash/splash_page.dart';

class Application extends StatelessWidget {
  final ApplicationBloc appBloc = ApplicationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: appBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryTextTheme: buildPrimaryTextTheme(),
            textTheme: buildTextTheme(),
            primaryColor: Color(0xFF19375F),
            cardColor: ShiffrColors.cardBlue,
            primaryColorBrightness: Brightness.dark,
//            primaryColorDark: Color(0xFF3F88C5),
            accentColor: Color(0xFF3F88C5),
            scaffoldBackgroundColor: ShiffrColors.bgBlue,
//            bottomAppBarColor: Color(0xFF0A1B32),
            buttonColor: ShiffrColors.btnBlue,
            tabBarTheme: TabBarTheme(labelColor: Colors.amber)),
        home: SplashPage(),
      ),
    );
  }

  TextTheme buildPrimaryTextTheme() {
    return TextTheme(
      body1: TextStyle(color: Colors.white, fontSize: 17.0),
      title: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.w600),
      headline: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w600),
      caption: TextStyle(color: Colors.white, fontSize: 12.0),
      subtitle: TextStyle(color: Colors.white, fontSize: 15.0),
    );
  }

  TextTheme buildTextTheme() {
    return TextTheme(
      body1: TextStyle(color: Colors.white, fontSize: 17.0),
      title: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
      headline: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w600),
      caption: TextStyle(color: Colors.white, fontSize: 12.0),
      subtitle: TextStyle(color: Colors.white, fontSize: 15.0),
    );
  }
}
