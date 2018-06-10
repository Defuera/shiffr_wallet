import 'package:flutter/material.dart';

import 'presenter_overview.dart';

class OverviewPage extends StatefulWidget {

  @override
  _OverviewPageState createState() {
    final OverviewPresenter _presenter = OverviewPresenter();
    _presenter.start();
    return _OverviewPageState(_presenter);
  }

}

class _OverviewPageState extends State<OverviewPage> {
  OverviewPresenter _presenter;

  _OverviewPageState(this._presenter);

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
