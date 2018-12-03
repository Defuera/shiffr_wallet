import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/app/colors.dart';
import 'package:shiffr_wallet/app/themes.dart';
import 'package:shiffr_wallet/splash/splash_page.dart';

class Application extends StatelessWidget {
  final ApplicationBloc appBloc = ApplicationBloc();

  @override
  Widget build(BuildContext context) =>
      BlocProvider<ApplicationBloc>(
        bloc: appBloc,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryTextTheme: primaryTextTheme,
              textTheme: textTheme,
              primaryColor: ShiffrColors.primary,
              cardColor: ShiffrColors.cardBlue,
              primaryColorBrightness: Brightness.dark,
//            primaryColorDark: Color(0xFF3F88C5),
              accentColor: ShiffrColors.accent,
              scaffoldBackgroundColor: ShiffrColors.bgBlue,
//            bottomAppBarColor: Color(0xFF0A1B32),
              buttonColor: ShiffrColors.btnBlue,
              disabledColor: ShiffrColors.disabledColor,
              tabBarTheme: TabBarTheme(labelColor: Colors.amber)),
          home: SplashPage(),
        ),
      );

}
