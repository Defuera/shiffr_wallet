import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';

class WalletDetailedPage extends StatefulWidget {
  final Wallet _wallet;

  WalletDetailedPage([this._wallet]);

  @override
  WalletDetailedPageState createState() {
    return WalletDetailedPageState(_wallet);
  }
}

enum Status { LOADING, DATA, ERROR }

class WalletDetailedPageState extends State<WalletDetailedPage> {
//  Status _status;
//
//  int _selectedTab;
  final Wallet _wallet;
//  WalletDetailedPresenter _presenter;
//
  WalletDetailedPageState(this._wallet);

  @override
  void initState() {
    super.initState();

//    _presenter = WalletDetailedPresenter(this, _wallet);
//    _presenter.start();
  }

  //region state manipulation

  void showLoading() {
//    setState(() {
//      _status = Status.LOADING;
//    });
  }

//  void showData(int tabIndex, List<Wallet> wallets) {
//    setState(() {
//      _selectedTab = tabIndex;
//      _wallets = wallets;
//      _status = Status.DATA;
//    });
//  }

  void showError() {
//    setState(() {
//      _status = Status.ERROR;
//    });
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    var widget;

//    switch (_status) {
//      case Status.LOADING:
//        widget = getLoadingView();
//        break;
//      case Status.DATA:
////        widget = getListView();
//        break;
//      case Status.ERROR:
//        widget = getErrorView();
//        break;
//    }

    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("WalletDetailed"),
      ),

    );
  }

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

//  Widget getListView() => ListView.builder(
//    itemCount: _wallets.length,
//    itemBuilder: (BuildContext context, int index) => getPairListItem(context, index),
//  );
//
//  GestureDetector getPairListItem(BuildContext context, int index) {
//    return GestureDetector(
//        child: InkWell(
//          onTap: () => _presenter.navigateTo(context, _data[index]),
//          child: new Container(
//            padding: new EdgeInsets.all(16.0),
//            child: getWalletWidget(_wallets[index]),
//          ),
//        ));
//  }
//
  Widget getErrorView() => GestureDetector(
    child: Center(
      child: Text("Network error, try again later"),
    ),
//    onTap: () => _presenter.loadData(),
  );
//
//  void showSnackbar(BuildContext context, String text) {
//    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
//  }

  getWalletWidget(Wallet wallet) => GestureDetector(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Text(
          wallet.currency,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "${wallet.amount}",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
        )
      ]),
      onTap: () => navigateTo(context, WalletDetailedPage()));

  navigateTo(BuildContext context, Widget page) => Navigator.push(
    context,
    new MaterialPageRoute(builder: (context) => page),
  );
}