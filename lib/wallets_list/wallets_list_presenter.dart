import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/app/model/api_error.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';
import 'package:shiffr_wallet/wallets_list/interactor.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class WalletsListPresenter {
  final Interactor _interactor = Interactor();

  final WalletsListPageState _viewState;
  final List<Wallet> _preloadedWallets;
  ViewModel _viewModel;

  WalletsListPresenter(this._viewState, this._preloadedWallets);

  void start() {
    if (_preloadedWallets != null) {
      onTabSelected(WalletType.exchange.index);
      onWalletsLoaded(_preloadedWallets);
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
      await onWalletsLoaded(wallets);
    } catch (socketException) {
      if (socketException is ApiError) {
        print(socketException.errorMessage);
      }
      print("exception: ${socketException.toString()}");
      _viewState.showError();
    }
  }

  Future onWalletsLoaded(wallets) async {
    final List<Wallet> exchangeWallets = wallets.where((it) => (it.type == WalletType.exchange)).toList();
    final List<Wallet> marginWallets = wallets.where((it) => (it.type == WalletType.margin)).toList();

//    sortWallets(exchangeWallets);
//    sortWallets(marginWallets);

    print("calculate sum for exchange");
    final exchangeSum = await calculateSum(exchangeWallets);
    print("calculate sum for margin");
    final marginSum = await calculateSum(marginWallets);

    _viewModel = ViewModel(exchangeWallets, marginWallets, exchangeSum, marginSum);

    onTabSelected(WalletType.exchange.index);
  }

  void sortWallets(List<Wallet> exchangeWallets) {
    exchangeWallets.sort((a, b){
      if (a.currency == "USD") {
        return 1;
      } else  if (a.currency == "USD") {
        return -1;
      } else {
        a.currency.compareTo(b.currency);
      }
    });
  }

  void navigateTo(BuildContext context, String pair) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => DetailedPage(pair)),
    );
  }

  onTabSelected(int tabIndex) {
    _viewState.showData(tabIndex, _viewModel);
  }

  Future<String> calculateSum(List<Wallet> wallets) async {
    final tickers = await _interactor.getTickersForWallets(wallets);

    var sum = 0.0;
    if (tickers != null) {
      tickers.forEach((ticker) {
        final wallet = _findWallet(wallets, ticker.symbol);
        if (ticker.lastPrice != null) {
          final value = ticker.lastPrice * wallet.amount;
          sum += value;
          print("wallet ${wallet.currency} amount ${wallet.amount} price ${ticker.lastPrice} = $value");
        }
      });
    }
    return sum.toStringAsFixed(2);
  }

  Wallet _findWallet(List<Wallet> wallets, String symbol) =>
      wallets.firstWhere((w) {
        return symbol.contains("${w.currency}USD");
      });
}

class ViewModel {
  List<Wallet> exchangeWallets;
  List<Wallet> marginWallets;
  String exchangeSum;
  String marginSum;

  ViewModel(this.exchangeWallets, this.marginWallets, this.exchangeSum, this.marginSum);
}
