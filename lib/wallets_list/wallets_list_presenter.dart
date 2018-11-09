import 'dart:async';

import 'package:shiffr_wallet/common/model/api_error.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';
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

    _sortWallets(exchangeWallets);
    _sortWallets(marginWallets);

    print("calculate sum for exchange");
    final exchangeSum = await _calculateSum(exchangeWallets);
    print("calculate sum for margin");
    final marginSum = await _calculateSum(marginWallets);

    _viewModel = ViewModel(exchangeWallets, marginWallets, exchangeSum, marginSum);

    onTabSelected(WalletType.exchange.index);
  }

  void _sortWallets(List<Wallet> wallets) => wallets.sort((a, b) {
        if (a.currency == "USD") {
          return -1;
        } else if (b.currency == "USD") {
          return 1;
        } else {
          return a.currency.compareTo(b.currency);
        }
      });

//  void navigateTo(BuildContext context, String pair) {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(builder: (context) => DetailedPage(pair)),
//    );
//  }

  onTabSelected(int tabIndex) {
    _viewState.showData(tabIndex, _viewModel);
  }

  Future<String> _calculateSum(List<Wallet> wallets) async {
    final tickers = await _interactor.getTickersForWallets(wallets);

    var sum = 0.0;
    if (tickers != null) {
      tickers.forEach((ticker) {
        final wallet = _findWallet(wallets, ticker.symbol.substring(1, 4)); //todo are symbols always of length 3? Don't think so!
        if (ticker.lastPrice != null) {
          final value = ticker.lastPrice * wallet.amount;
          sum += value;
          print("wallet ${wallet.currency} amount ${wallet.amount} price ${ticker.lastPrice} = $value");
        }
      });
    }

    final fiatWallet = _findWallet(wallets, "USD");
    print("add usd amount ${fiatWallet.amount}");
    sum += fiatWallet.amount;
    return sum.toStringAsFixed(2);
  }

  Wallet _findWallet(List<Wallet> wallets, String symbol) => wallets.firstWhere((w) {
        return w.currency == symbol;
      });
}

class ViewModel {
  List<Wallet> exchangeWallets;
  List<Wallet> marginWallets;
  String exchangeSum;
  String marginSum;

  ViewModel(this.exchangeWallets, this.marginWallets, this.exchangeSum, this.marginSum);
}
