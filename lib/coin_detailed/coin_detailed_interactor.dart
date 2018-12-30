import 'package:shiffr_wallet/common/api/bitfinex/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_ticker.dart';

class CoinDetailedInteractor {

  final BitfinexApiV2 _api;
  CoinDetailedInteractor(this._api);

  Future<Ticker> getTicker(String symbol, String baseCurrency) => _api.getTradingTicker(pair: _toPair(symbol, baseCurrency));

  String _toPair(String symbol, String baseCurrency) => "$symbol$baseCurrency";

}