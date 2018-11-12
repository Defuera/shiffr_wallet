import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/playground/playground_page.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_page.dart';
import 'package:shiffr_wallet/wallets_list/wallet_list_state.dart';
import 'package:shiffr_wallet/wallets_list/wallet_widget.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_presenter.dart';

class WalletsListPage extends StatefulWidget {
  final List<Wallet> _wallets;

  WalletsListPage([this._wallets]);

  @override
  WalletsListPageState createState() => WalletsListPageState(_wallets);
}


const HEADERS_COUNT = 1;

class WalletsListPageState extends State<WalletsListPage> {
  WalletsListBloc _bloc;

  final List<Wallet> _wallets;

  WalletsListPageState(this._wallets);

  @override
  void initState() {
    super.initState();
    _bloc = WalletsListBloc(_wallets);
    _bloc.start();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    return BlocBuilder<dynamic, WalletListState>(
        bloc: _bloc,
        builder: (
          BuildContext context,
          WalletListState loginState,
        ) {
          switch (loginState.status) {
            case WalletListStatus.LOADING:
              widget = getLoadingView();
              break;
            case WalletListStatus.DATA:
              widget = getListView(loginState.tabIndex, loginState.viewModel);
              break;
            case WalletListStatus.ERROR:
              widget = getErrorView();
              break;
          }

          return buildPage(context, loginState.tabIndex, widget);
        });

  }

  Scaffold buildPage(BuildContext context, int tabIndex, Widget widget) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text("WalletsList"),
        leading: Container(), //to remove arrow
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Icon(
                Icons.games,
                color: Colors.white,
              ),
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
        onTap: (int index) => _bloc.onTabSelected(index),
        currentIndex: tabIndex,
      ),
    );
  }

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getListView(tabIndex, viewModel) {
    List<Wallet> wallets;
    String sum;

    switch (tabIndex) {
      case 0:
        wallets = viewModel.exchangeWallets;
        sum = viewModel.exchangeSum;
        break;
      case 1:
        wallets = viewModel.marginWallets;
        sum = viewModel.marginSum;
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
        onTap: () => _bloc.loadData(),
      );

  void showSnackbar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(text)));
  }

  getWalletWidget(Wallet wallet) => GestureDetector(
        child: InkWell(onTap: () => navigateTo(context, WalletDetailedPage(wallet)), child: WalletWidget(wallet)),
      );
}
