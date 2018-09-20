//[
//BID, 211.46,
//BID_SIZE, 1569.75348181
//ASK, 211.47
//ASK_SIZE, 424.7547338
//DAILY_CHANGE, 3.96
//DAILY_CHANGE_PERC, 0.0191
//LAST_PRICE, 211.46
//VOLUME, 551613.19668796
//HIGH, 216.805001
//LOW 196
//]

class Ticker {
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

  Ticker({this.bid, this.bidSize, this.ask, this.askSize, this.dailyChange, this.dailyChangePerc, this.lastPrice,
      this.volume, this.high, this.low});


  factory Ticker.fromJson(dynamic jsonList) =>
      Ticker(
          bid: jsonList[0],
          bidSize: jsonList[1],
          ask: jsonList[2],
          askSize: jsonList[3],
          dailyChange: jsonList[4],
          dailyChangePerc: jsonList[5],
          lastPrice: jsonList[6],
          volume: jsonList[7],
          high: jsonList[8],
          low: jsonList[9]
      );
}
