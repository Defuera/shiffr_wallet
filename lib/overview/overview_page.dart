import 'package:flutter/material.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';

import 'overview_presenter.dart';

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

  void showError() {
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
        widget = getListView();
        break;
      case Status.ERROR:
        widget = getErrorView();
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

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getListView() => ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) => getPairListItem(context, index),
      );

  GestureDetector getPairListItem(BuildContext context, int index) {
    return GestureDetector(
        child: InkWell(
          onTap: () => _presenter.navigateTo(context, _data[index]),
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: Text(
              _data[index],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
    ));
  }

  Widget getErrorView() => GestureDetector(
        child: Center(
          child: Text("Network error, try again later"),
        ),
        onTap: () => _presenter.loadListPairs(),
      );

  void showSnackbar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
  }
}
