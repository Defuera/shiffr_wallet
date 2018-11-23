
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';

class CoinDetailedInteractor{

  final BitfinexApiV2 _api;
  CoinDetailedInteractor(this._api);

  Future<Ticker> getTicker(String symbol, String baseCurrency) => _api.getTradingTicker(pair: "$symbol$baseCurrency");

}