import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/model_order.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/app/navigation_helper.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_presenter.dart';
import 'package:shiffr_wallet/wallets_list/wallet_widget.dart';

class WalletDetailedPage extends StatefulWidget {
  final Wallet _wallet;

  WalletDetailedPage(this._wallet);

  @override
  WalletDetailedPageState createState() {
    return WalletDetailedPageState(_wallet);
  }
}

enum Status { LOADING, DATA, ERROR }

class WalletDetailedPageState extends State<WalletDetailedPage> {
  Status _status;

//
  List<Order> _orders;
  final Wallet _wallet;
  WalletDetailedPresenter _presenter;

//
  WalletDetailedPageState(this._wallet);

  @override
  void initState() {
    super.initState();

    _presenter = WalletDetailedPresenter(this, _wallet);
    _presenter.start();
  }

  //region state manipulation

  void showLoading() {
    setState(() {
      _status = Status.LOADING;
    });
  }

  void showData(List<Order> orders) {
    setState(() {
      _orders = orders;
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
    Widget widget = _createLoadingView();

    switch (_status) {
      case Status.LOADING:
        widget = _createLoadingView();
        break;
      case Status.DATA:
        widget = _createListOrders(_orders);
        break;
      case Status.ERROR:
        widget = _createErrorView();
        break;
    }

    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text("WalletDetailed"),
        ),
        body: Column(
          children: <Widget>[
            WalletWidget(_wallet),
            widget,
          ],
        ));
  }

  Widget _createLoadingView() => Center(child: CircularProgressIndicator());

  Widget _createListOrders(List<Order> orders) => ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) => _createOrderWidget(context, orders[index]),
      );

  Widget _createOrderWidget(BuildContext context, Order order) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Text(
            order.symbol,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Text(
            "${order.amount}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
          ),
          Text(
            "${order.price}",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
          )
        ]));
  }

//
  Widget _createErrorView() => GestureDetector(
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
      onTap: () => navigateTo(context, WalletDetailedPage(wallet)));
}
