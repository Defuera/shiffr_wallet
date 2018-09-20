import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_page.dart';
import 'package:shiffr_wallet/wallets_list/wallets_list_page.dart';

class WalletDetailedPresenter {
//  final _repository = BitfinexRepository();
  final _api = BitfinexApiV2();

  final WalletDetailedPageState _viewState;
  Wallet _wallet;

  WalletDetailedPresenter(this._viewState, this._wallet);

  void start() {
//    if (_wallet != null) {
//      onTabSelected(WalletType.exchange.index);
//    } else {
//      _viewState.showLoading();
//      loadData();
//    }
  }

  void loadData() async {
//    print("WalletsListPresenter loadData");
//    _viewState.showLoading();
//
//    try {
//      _wallet = await _api.getWallets();
//
//      print("loadListPairs: $_wallet");
//
//      onTabSelected(WalletType.exchange.index);
//    } catch (socketException) {
//      print("exception: ${socketException.toString()}");
//      _viewState.showError();
//    }
  }
//
//  void navigateTo(BuildContext context, String pair) {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(builder: (context) => DetailedPage(pair)),
//    );
//  }
//
//  onTabSelected(int tabIndex) {
//    if (_wallet != null) {
//      switch (tabIndex) {
//        case 0:
//          _viewState.showData(0, _wallet.where((it) => (it.type == WalletType.exchange)).toList());
//          break;
//        case 1:
//          _viewState.showData(1, _wallet.where((it) => (it.type == WalletType.margin)).toList());
//          break;
//      }
//    }
//  }
}
