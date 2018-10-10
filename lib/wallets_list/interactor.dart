import 'dart:async';

import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/app/model/model_ticker.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';

class Interactor {
  final _api = BitfinexApiV2();

  getOverviewList() {}

  getWallets() => _api.getWallets();

  Future<List<Ticker>> getTickersForWallets(List<Wallet> wallets1) async {
    var pairs = List<String>();
    wallets1.forEach((wallet) {
      if (wallet.currency != "USD") {
        pairs.add("${wallet.currency}USD"); //todo usd to const
      }
    });

    final tickers = await _api.getTradingTickers(pairs);
    return tickers;
  }

}
