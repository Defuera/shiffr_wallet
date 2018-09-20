import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';
import 'package:shiffr_wallet/wallets_list/interactor.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class WalletsListPresenter {
  final Interactor _interactor = Interactor();

  final WalletsListPageState _viewState;
  List<Wallet> _preloadedWallets;
  List<Wallet> _exchangeWallets;
  List<Wallet> _marginWallets;

  WalletsListPresenter(this._viewState, this._preloadedWallets);

  void start() {
    if (_preloadedWallets != null) {
      onTabSelected(WalletType.exchange.index);
    } else {
      _viewState.showLoading();
      loadData();
    }
  }

  void loadData() async {
    print("WalletsListPresenter loadData");
    _viewState.showLoading();

    try {
      final wallets = await _interactor.getWallets();
//      final _tickers = await getTickersForWallets(wallets);
      _exchangeWallets = wallets.where((it) => (it.type == WalletType.exchange)).toList();
      _marginWallets = wallets.where((it) => (it.type == WalletType.margin)).toList();

//      print("loadListPairs: $_wallets");

      onTabSelected(WalletType.exchange.index);
    } catch (socketException) {
      print("exception: ${socketException.toString()}");
      _viewState.showError();
    }
  }

  void navigateTo(BuildContext context, String pair) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => DetailedPage(pair)),
    );
  }

  onTabSelected(int tabIndex) {
    switch (tabIndex) {
      case 0:
        if (_exchangeWallets != null) {
          _viewState.showData(0, _exchangeWallets);
        }
        break;
      case 1:
        if (_marginWallets != null) {
          _viewState.showData(1, _marginWallets);
        }
        break;
    }
}}
