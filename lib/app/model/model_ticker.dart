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


  factory Ticker.fromJson(dynamic json) =>
      Ticker(
          symbol: json[0],
          bid: json[1],
          bidSize: json[2],
          ask: json[3],
          askSize: json[4],
          dailyChange: json[5],
          dailyChangePerc: json[6],
          lastPrice: json[7],
          volume: json[8],
          high: json[9],
          low: json[10]
      );
}

class TickerList {
  List<Ticker> tickers;

  TickerList({this.tickers});

  factory TickerList.fromJson(List<dynamic> json) =>
      TickerList(tickers: (json.map((i) => Ticker.fromJson(i)).toList()));
}
