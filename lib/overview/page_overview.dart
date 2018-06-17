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

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getList() => ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: InkWell(
              // When the user taps the button, show a snackbar
              onTap: () {
                Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text("Buy more ${_data[index]}"),
                    ));
              },
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                child: Text(
                  _data[index],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      );
}

//child = Container(
//child: Text(
//_data[index],
//style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//),
//padding: EdgeInsets.all(16.0),
//),
//onTap: () => ,
