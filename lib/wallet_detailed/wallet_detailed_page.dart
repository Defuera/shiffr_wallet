import 'package:flutter/material.dart';
import 'package:shiffr_wallet/app/model/model_order.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/app/navigation_helper.dart';
import 'package:shiffr_wallet/wallet_detailed/order_list_item_widget.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_presenter.dart';
import 'package:shiffr_wallet/wallets_list/wallet_widget.dart';

const _ORDERS_HEADER_COUNT = 2;

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

  List<Order> _activeOrders;
  List<Order> _historicOrders;
  final Wallet _wallet;
  WalletDetailedPresenter _presenter;

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

  void showData(List<Order> activeOrders, List<Order> historicOrders) {
    setState(() {
      _activeOrders = activeOrders;
      _historicOrders = historicOrders;
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
    Widget widget;

    switch (_status) {
      case Status.LOADING:
        widget = _createLoadingView();
        break;
      case Status.DATA:
        widget = _createListOrders();
        break;
      case Status.ERROR:
        widget = _createErrorView();
        break;
      default:
        widget = _createLoadingView();
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

  Widget _createListOrders() {
    var itemsCount = _activeOrders.length + _historicOrders.length + _ORDERS_HEADER_COUNT;
    return Expanded(
        child: ListView.builder(
          itemCount: itemsCount,
          itemBuilder: (BuildContext context, int index) {
            final itemsBeforeHistoricOrders = _activeOrders.length + _ORDERS_HEADER_COUNT;
            final shouldShowHistoricOrder = index >= itemsBeforeHistoricOrders - 1;

            if (index == 0) {
              return _createTitleWidget("Active");
            } else if (index == _activeOrders.length + 1) {
              return _createTitleWidget("Fulfilled");
            } else {

              var order;
              var itemIndex;
              if (shouldShowHistoricOrder) {
                itemIndex = index - itemsBeforeHistoricOrders;
                order = _historicOrders[itemIndex];
              } else {
                itemIndex = index - 1;
                order = _activeOrders[itemIndex];
              }
              final isLastItem = itemIndex == itemsCount - 1;
              return OrderListItemWidget(order, !isLastItem);
            }
          },
        ));
  }

  Widget _createTitleWidget(String title) =>
      Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ));

  Widget _createErrorView() =>
      GestureDetector(
        child: Center(
          child: Text("Network error, try again later"),
        ),
//    onTap: () => _presenter.loadData(),
      );

//
//  void showSnackbar(BuildContext context, String text) {
//    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
//  }

  getWalletWidget(Wallet wallet) =>
      GestureDetector(
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
