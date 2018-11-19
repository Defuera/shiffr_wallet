import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  ApplicationBloc _appBloc;

  @override
  Widget build(BuildContext context) {
    _appBloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "WalletsList",
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ic_anonymous.png"),
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcATop),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment(0.0, 1.0),
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                      child: Text(
                        "Logout",
                      ),
                      onPressed: () => _appBloc.logout(context)),
                ),
              ],
            ),
          )),
    );
  }
}
