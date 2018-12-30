import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
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
          theme: shiffrThemeData,
          home: SplashPage(),
        ),
      );

}
