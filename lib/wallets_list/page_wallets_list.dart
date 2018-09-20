import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/wallet_detailed/page_wallet_detailed.dart';

import 'presenter_wallets_list.dart';

class WalletsListPage extends StatefulWidget {
  final List<Wallet> _wallets;

  WalletsListPage([this._wallets]);

  @override
  WalletsListPageState createState() {
    return WalletsListPageState(_wallets);
  }
}

enum Status { LOADING, DATA, ERROR }

class WalletsListPageState extends State<WalletsListPage> {
  Status _status;

  int _selectedTab = 0;
  List<Wallet> _wallets;
  WalletsListPresenter _presenter;

  WalletsListPageState(this._wallets);

  @override
  void initState() {
    super.initState();

    _presenter = WalletsListPresenter(this, _wallets);
    _presenter.start();
  }

  //region state manipulation

  void showLoading() {
    setState(() {
      _status = Status.LOADING;
    });
  }

  void showData(int tabIndex, List<Wallet> wallets) {
    setState(() {
      _selectedTab = tabIndex;
      _wallets = wallets;
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
        title: Text("WalletsList"),
      ),
      body: widget,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.atm),
              title: Text("Exchange"),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.atm),
              title: Text("Margin"),
              backgroundColor: Colors.black),
        ],
        fixedColor: null, //todo it's white, should be primary
        onTap: (int index) => _presenter.onTabSelected(index),
        currentIndex: _selectedTab,
      ),
    );
  }

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getListView() => ListView.builder(
        itemCount: _wallets.length,
        itemBuilder: (BuildContext context, int index) =>
            getWalletWidget(_wallets[index]),
      );

  Widget getErrorView() => GestureDetector(
        child: Center(
          child: Text("Network error, try again later"),
        ),
        onTap: () => _presenter.loadData(),
      );

  void showSnackbar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
  }

  getWalletWidget(Wallet wallet) => GestureDetector(
        child: InkWell(
            onTap: () => navigateTo(context, WalletDetailedPage()),
            child: new Container(
                padding: new EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        wallet.currency,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${wallet.amount}",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal),
                      )
                    ]))),
      );

  navigateTo(BuildContext context, Widget page) => Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => page),
      );
}
