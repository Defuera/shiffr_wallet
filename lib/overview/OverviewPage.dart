import 'package:flutter/material.dart';

import 'OverviewPresenter.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final OverviewPresenter _presenter = OverviewPresenter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("Overview"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
