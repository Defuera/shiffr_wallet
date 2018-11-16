import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shiffr_wallet/common/model/api_error.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';
import 'package:shiffr_wallet/wallets_list/interactor.dart';
import 'package:shiffr_wallet/wallets_list/wallet_list_state.dart';
import 'package:shiffr_wallet/wallets_list/wallet_ticker.dart';

class WalletsListBloc extends Bloc<dynamic, WalletListState> {
  final Interactor _interactor = Interactor();

  ViewModel _viewModel;

  final List<Wallet> _preloadedWallets;

  WalletsListBloc(this._preloadedWallets);

  //region BLOC

  @override
  get initialState => WalletListState.loading();

  @override
  Stream<WalletListState> mapEventToState(WalletListState currentState, event) async* {
    if (event is WalletListState) {
      yield event;
    } else {
      throw Exception("unknown event");
    }
  }

  //endregion

  void start() {
    if (_preloadedWallets != null) {
      onTabSelected(WalletType.exchange.index);
      onWalletsLoaded(_preloadedWallets);
    } else {
      dispatch(WalletListState.loading());
      loadData();
    }
  }

  onTabSelected(int tabIndex) {
    dispatch(WalletListState.dataLoaded(tabIndex, _viewModel));
  }

  void loadData() async {
    print("WalletsListPresenter loadData");
    dispatch(WalletListState.loading());

    try {
      final wallets = await _interactor.getWallets();
      await onWalletsLoaded(wallets);
    } catch (socketException) {
      if (socketException is ApiError) {
        print(socketException.errorMessage);
      }
      print("exception: ${socketException.toString()}");
      dispatch(WalletListState.error());
    }
  }

  Future onWalletsLoaded(wallets) async {

    try {
      final List<Wallet> exchangeWallets = wallets.where((it) => (it.type == WalletType.exchange)).toList();
      final List<Wallet> marginWallets = wallets.where((it) => (it.type == WalletType.margin)).toList();

      _sortWallets(exchangeWallets);
      _sortWallets(marginWallets);

      final exchangeWalletTickers = await getTickers(exchangeWallets);
      final exchangeSum = _calculateSum(exchangeWalletTickers);

      final marginWalletTickers = await getTickers(marginWallets);
      final marginSum = _calculateSum(marginWalletTickers);

      _viewModel = ViewModel(exchangeWalletTickers, marginWalletTickers, exchangeSum, marginSum);
    } catch (exception){
      print(exception.toString());
    }

    onTabSelected(WalletType.exchange.index);
  }

  /// Put base currency wallet on top, the rest in alphabetic order
  void _sortWallets(List<Wallet> wallets) => wallets.sort((a, b) {
        if (a.currency == "USD") {
          return -1;
        } else if (b.currency == "USD") {
          return 1;
        } else {
          return a.currency.compareTo(b.currency);
        }
      });

  Future<List<WalletTicker>> getTickers(List<Wallet> wallets) async { //todo private, naming
    final tickers = await _interactor.getTickersForWallets(wallets);
    final list = List<WalletTicker>();

    tickers.forEach((ticker) {
      var symbol = ticker.symbol.substring(1, 4); //todo are symbols always of length 3? Don't think so!
      final wallet = _findWallet(wallets, symbol);
      list.add(WalletTicker(symbol: symbol, wallet: wallet, ticker: ticker));
    });
    return list;
  }

  String _calculateSum(List<WalletTicker> walletTicker) {
    var sum = 0.0;
    walletTicker.forEach((item) {
      final ticker = item.ticker;
      final wallet = item.wallet;

      var isBaseCurrency = item.symbol != "USD";
      if (ticker.lastPrice != null && isBaseCurrency) {
        sum += ticker.lastPrice * wallet.amount;
      } else if (isBaseCurrency){
        sum += wallet.amount;
      }
    });

    return sum.toStringAsFixed(2);
  }

  Wallet _findWallet(List<Wallet> wallets, String symbol) => wallets.firstWhere((w) {
        return w.currency == symbol;
      });
}

class ViewModel {
  List<WalletTicker> exchangeWalletTickers;
  List<WalletTicker> marginWalletTickers;
  String exchangeSum;
  String marginSum;

  ViewModel(this.exchangeWalletTickers, this.marginWalletTickers, this.exchangeSum, this.marginSum);
}
