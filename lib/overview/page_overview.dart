import 'package:flutter/material.dart';

import 'presenter_overview.dart';

class OverviewPage extends StatefulWidget {

  @override
  OverviewPageState createState() {
    return OverviewPageState();
  }

}

enum Status { LOADING, DATA, ERROR }

class OverviewPageState extends State<OverviewPage> {
  var _status = Status.LOADING;
  List<String> _data;

  OverviewPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = OverviewPresenter(this);
    _presenter.start();
  }

  //region state manipulation

  void showLoading() {
    setState(() {
      _status = Status.LOADING;
    });
  }

  void showData(List<String> data) {
    setState(() {
      _data = data;
      _status = Status.DATA;
    });
  }

  void showError(List<String> data) {
    setState(() {
      _status = Status.ERROR;
    });
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    var widget;

    switch (_status) {
      case Status.LOADING:
        widget = getLoadingView();
        break;
      case Status.DATA:
        widget = getList();
        break;
      case Status.ERROR:
        widget = getLoadingView(); //todo
        break;
    }

    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("Overview"),
      ),
      body: widget,
    );
  }

  Widget getLoadingView() => CircularProgressIndicator();

  Widget getList() =>
      ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) => Text(_data[index]),
      );
}
