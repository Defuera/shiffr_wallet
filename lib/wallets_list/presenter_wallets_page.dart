import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/app/model/Wallet.dart';
import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';
import 'package:shiffr_wallet/wallets_list/page_wallets_list.dart';

class WalletsListPresenter {
//  final _repository = BitfinexRepository();
  final _api = BitfinexApiV2();

  final WalletsListPageState _viewState;
  List<Wallet> _wallets;

  WalletsListPresenter(this._viewState, this._wallets);

  void start() {
    if (_wallets != null) {
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
      _wallets = await _api.getWallets();

      print("loadListPairs: $_wallets");

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
    if (_wallets != null) {
      switch (tabIndex) {
        case 0:
          _viewState.showData(0, _wallets.where((it) => (it.type == WalletType.exchange)).toList());
          break;
        case 1:
          _viewState.showData(1, _wallets.where((it) => (it.type == WalletType.margin)).toList());
          break;
      }
    }
  }
}
