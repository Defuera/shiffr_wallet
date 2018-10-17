//import 'package:flutter/material.dart';
//
//import 'presenter_detailed.dart';
//
//class DetailedPage extends StatefulWidget {
//  final String _pair;
//
//  DetailedPage(this._pair);
//
//  @override
//  DetailedPageState createState() {
//    return DetailedPageState(_pair);
//  }
//}
//
//enum Status { LOADING, DATA, ERROR }
//
//class DetailedPageState extends State<DetailedPage> {
//  var _status = Status.LOADING;
//  List<String> _data;
//
//  DetailedPresenter _presenter;
//
//  final String _pair;
//
//  DetailedPageState(this._pair);
//
//  @override
//  void initState() {
//    super.initState();
//    _presenter = DetailedPresenter(this, _pair);
//    _presenter.start();
//  }
//
//  //region state manipulation
//
//  void showLoading() {
//    setState(() {
//      _status = Status.LOADING;
//    });
//  }
//
//  void showData(List<String> data) {
//    setState(() {
//      _data = data;
//      _status = Status.DATA;
//    });
//  }
//
//  void showError() {
//    setState(() {
//      _status = Status.ERROR;
//    });
//  }
//
//  //endregion
//
//  @override
//  Widget build(BuildContext context) {
//    var widget;
//
//    switch (_status) {
//      case Status.LOADING:
//        widget = getLoadingView();
//        break;
//      case Status.DATA:
//        widget = getListView();
//        break;
//      case Status.ERROR:
//        widget = getErrorView();
//        break;
//    }
//
//    return Scaffold(
//      appBar: AppBar(
//        primary: true,
//        title: Text(_pair),
//      ),
//      body: widget,
//    );
//  }
//
//  Widget getLoadingView() => Center(child: CircularProgressIndicator());
//
//  Widget getListView() => ListView.builder(
//        itemCount: _data.length,
//        itemBuilder: (BuildContext context, int index) => GestureDetector(
//                child: InkWell(
//              // When the user taps the button, show a snackbar
//              onTap: () {
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => DetailedPage(_data[index])),
////                    DetailedPage(_data[index])
//                );
////                showSnackbar(context, "Buy more ${_data[index]}");
//              },
//              child: new Container(
//                padding: new EdgeInsets.all(16.0),
//                child: Text(
//                  _data[index],
//                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                ),
//              ),
//            )),
//      );
//
//  Widget getErrorView() => GestureDetector(
//        child: Center(
//          child: Text("Network error, try again later"),
//        ),
//        onTap: () => _presenter.loadPairOrders(),
//      );
//
//  void showSnackbar(BuildContext context, String text) {
//    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
//  }
//}
