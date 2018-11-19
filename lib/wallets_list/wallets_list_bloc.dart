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

      final exchangeWalletTickers = await _getTickers(exchangeWallets);
      final exchangeSum = _calculateSum(exchangeWalletTickers);

      final marginWalletTickers = await _getTickers(marginWallets);
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

  Future<List<WalletTicker>> _getTickers(List<Wallet> wallets) async {
    final tickers = await _interactor.getTickersForWallets(wallets);
    final list = List<WalletTicker>();

    wallets.forEach((wallet) {
      final symbol = wallet.currency;
      final ticker = tickers.firstWhere((t) => t.symbol.contains(symbol), orElse: null); //todo can be a problem
      list.add(WalletTicker(symbol: symbol, wallet: wallet, ticker: ticker));
    });
    return list;
  }

  String _calculateSum(List<WalletTicker> walletTickers) {
    var sum = 0.0;
    walletTickers.forEach((item) {
      final ticker = item.ticker;
      final wallet = item.wallet;
      final isBaseCurrency = item.symbol == "USD"; //todo

      if (ticker.lastPrice != null && !isBaseCurrency) {
        sum += ticker.lastPrice * wallet.amount;
      } else if (isBaseCurrency) {
        sum += wallet.amount;
      }
    });

    return sum.toStringAsFixed(2);
  }

}

class ViewModel {
  List<WalletTicker> exchangeWalletTickers;
  List<WalletTicker> marginWalletTickers;
  String exchangeSum;
  String marginSum;

  ViewModel(this.exchangeWalletTickers, this.marginWalletTickers, this.exchangeSum, this.marginSum);
}
