
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/model/model_candle.dart';

class CandleRepository {

  final BitfinexApiV2 _api;
  CandleRepository(this._api);

  Future<List<Candle>> getCandles({
    String symbol,
    String baseCurrency,
    String timeFrame : "1D",
  }) => _api.getTradingCandles(_toPair(symbol, baseCurrency), timeFrame);

  String _toPair(String symbol, String baseCurrency) => "$symbol$baseCurrency";

}