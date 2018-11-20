import 'package:shiffr_wallet/common/model/conversion_utils.dart';

class Ticker {
  final String symbol;
  final double bid;
  final double bidSize;
  final double ask;
  final double askSize;
  final double dailyChange;
  final double dailyChangePerc;
  final double lastPrice;
  final double volume;
  final double high;
  final double low;

  Ticker({this.symbol, this.bid, this.bidSize, this.ask, this.askSize, this.dailyChange, this.dailyChangePerc, this.lastPrice,
      this.volume, this.high, this.low});


  factory Ticker.fromJson(dynamic json) {
    print(json);
      return Ticker(
          symbol: json[0],
          bid: parseNullableDouble(json[1]),
          bidSize: parseNullableDouble(json[2]),
          ask: parseNullableDouble(json[3]),
          askSize: parseNullableDouble(json[4]),
          dailyChange: parseNullableDouble(json[5]),
          dailyChangePerc: parseNullableDouble(json[6]),
          lastPrice: parseNullableDouble(json[7]),
          volume: parseNullableDouble(json[8]),
          high: parseNullableDouble(json[9]),
          low: parseNullableDouble(json[10])
      );
  }

  double marketCap() => volume * lastPrice;
}

class TickerList {
  List<Ticker> tickers;

  TickerList({this.tickers});

  factory TickerList.fromJson(List<dynamic> json) =>
      TickerList(tickers: (json.map((i) => Ticker.fromJson(i)).toList()));
}
