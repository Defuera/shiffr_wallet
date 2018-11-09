import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/playground/playground_page.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_page.dart';
import 'package:shiffr_wallet/wallets_list/wallet_widget.dart';

import 'wallets_list_presenter.dart';

class WalletsListPage extends StatefulWidget {
  final List<Wallet> _wallets;

  WalletsListPage([this._wallets]);

  @override
  WalletsListPageState createState() => WalletsListPageState(_wallets);

}

enum Status { LOADING, DATA, ERROR }
final HEADERS_COUNT = 1;

class WalletsListPageState extends State<WalletsListPage> {
  Status _status;

  int _selectedTab = 0;
  ViewModel _viewModel;

  final List<Wallet> _wallets;
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

  void showData(int tabIndex, ViewModel viewModel) {
    setState(() {
      _status = Status.DATA;
      _selectedTab = tabIndex;
      _viewModel = viewModel;
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
        leading: Container(), //to remove arrow
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Icon(Icons.games, color: Colors.white,),
              onTap: () => navigateTo(context, PlaygroundPage()),
            ),
          )
        ],
      ),
      body: widget,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.atm), title: Text("Exchange"), backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(Icons.atm), title: Text("Margin"), backgroundColor: Colors.black),
        ],
        fixedColor: null, //todo it's white, should be primary
        onTap: (int index) => _presenter.onTabSelected(index),
        currentIndex: _selectedTab,
      ),
    );
  }

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getListView() {
    List<Wallet> wallets;
    String sum;

    switch (_selectedTab) {
      case 0:
        wallets = _viewModel.exchangeWallets;
        sum = _viewModel.exchangeSum;
        break;
      case 1:
        wallets = _viewModel.marginWallets;
        sum = _viewModel.marginSum;
        break;
    }

    return ListView.builder(
      itemCount: wallets.length + HEADERS_COUNT,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return summaryItem(sum);
          default:
            return getWalletWidget(wallets[index - HEADERS_COUNT]);
        }
      },
    );
  }

  Widget summaryItem(String sum) {
    return new Container(
        padding: new EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Text(
              "Total sum, USD",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              sum,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
            )
          ]));
  }

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
            onTap: () => navigateTo(context, WalletDetailedPage(wallet)),
            child: WalletWidget(wallet)
        ),
      );

}
