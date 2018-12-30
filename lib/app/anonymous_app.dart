import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/app/themes.dart';
import 'package:shiffr_wallet/tickers/tickers_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class AnonymousApp extends StatelessWidget {
  final ApplicationBloc appBloc = ApplicationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: appBloc,
      child: MaterialApp(
//        localizationsDelegates: [
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//        ],
//        supportedLocales: [
//          const Locale('en', 'US'),
//          const Locale('ru', 'RU'),
//        ],
        title: 'Flutter Demo',
        theme: shiffrThemeData,
        home: TickersPage(),
      ),
    );
  }

}
