import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/app/themes.dart';
import 'package:shiffr_wallet/generated/i18n.dart';
import 'package:shiffr_wallet/tickers/tickers_page.dart';

class AnonymousApp extends StatelessWidget {
  final ApplicationBloc appBloc = ApplicationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: appBloc,
      child: MaterialApp(
        localizationsDelegates: [S.delegate],
        supportedLocales: S.delegate.supportedLocales,
        theme: shiffrThemeData,
        home: TickersPage(),
      ),
    );
  }
}
