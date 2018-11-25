import 'package:shiffr_wallet/common/model/conversion_utils.dart';

class Candle {
  final int timestamp;
  final double open;
  final double close;
  final double high;
  final double low;
  final double volume;

  Candle({this.timestamp, this.open, this.close, this.high, this.low, this.volume});

  factory Candle.fromJson(dynamic json) {
    print(json);
    return Candle(
      timestamp: json[0],
      open: parseNullableDouble(json[1]),
      close: parseNullableDouble(json[2]),
      high: parseNullableDouble(json[3]),
      low: parseNullableDouble(json[4]),
      volume: parseNullableDouble(json[5]),
    );
  }

}

class CandleList {
  List<Candle> candles;

  CandleList({this.candles});

  factory CandleList.fromJson(List<dynamic> json) =>
      CandleList(candles: (json.map((i) => Candle.fromJson(i)).toList()));
}
