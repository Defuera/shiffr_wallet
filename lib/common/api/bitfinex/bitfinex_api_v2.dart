import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shiffr_wallet/common/api/response_handling_utils.dart';
import 'package:shiffr_wallet/common/api/bitfinex/bitfinex_signer.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_candle.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_order.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_ticker.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_wallet.dart';
import 'package:shiffr_wallet/common/preferences.dart';

class BitfinexApiV2 {
  final _prefs = Preferences();

  //authenticated endpoints
  final baseUrl = "https://api.bitfinex.com";
  final pathWallets = "v2/auth/r/wallets";
  final pathOrdersByPair = "v2/auth/r/orders";

  //not auth endpoints
  final pathTicker = "v2/tickers?symbols=";
  final pathCandles = "v2/candles/trade";

  Future<List<Wallet>> getWalletsToLogin(String key, String secret) async {
    var responseString = await _authPost(pathWallets, key: key, secret: secret);
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<List<Wallet>> getWallets() async {
    var responseString = await _authPost(pathWallets);
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<Ticker> getTradingTicker({String pair}) async =>
      getTradingTickers(pairs: List.of([pair])).then((list) => list.first);

  Future<List<Ticker>> getTradingTickers({List<String> pairs}) async {
//    print("getTradingTicker pair: $pair");
    var pathArgs = "";
    if (pairs != null) {
      pairs.forEach((pair) {
        pathArgs += "t$pair,";
      });
    } else {
      pathArgs = "ALL";
    }
    final responseString = await _anonymousGet("$pathTicker$pathArgs");
    final map = await json.decode(responseString);

    return TickerList.fromJson(map).tickers;
  }

  ///https://api.bitfinex.com/v2/candles/trade:TimeFrame:Symbol/Section
  Future<List<Candle>> getTradingCandles(String pair, String timeFrame, {int limit: 30}) async {
    final responseString = await _anonymousGet("$pathCandles:$timeFrame:t$pair/hist?$limit");
    final map = await json.decode(responseString);

    return CandleList.fromJson(map).candles;
  }

  Future<List<Order>> getTradingListOrdersHistory(String symbol, String fiat) async {
    var responseString = await _authPost("$pathOrdersByPair/t$symbol$fiat/hist");
    var map = await json.decode(responseString);

    return OrderList.fromJson(map).orders;
  }

  Future<List<Order>> getActiveTradingListOrders(String symbol, String fiat) async {
    var responseString = await _authPost("$pathOrdersByPair/t$symbol$fiat");
    var map = await json.decode(responseString);

    return OrderList.fromJson(map).orders;
  }

  //region shiffr http methods

  Future<String> _anonymousPost(String path, {String key, String secret}) async {
    final response = await post("$baseUrl/$path");
    return handleResponse(response);
  }

  Future<String> _anonymousGet(String path, {String key, String secret}) async {
    final response = await get("$baseUrl/$path");
    return handleResponse(response);
  }

  Future<String> _authPost(String path, {String key, String secret}) async {
    final response = await post(
      "$baseUrl/$path",
      headers: await _prepareHeaders(key, secret, path),
    );

    return handleResponse(response);
  }

  Future<String> _authGet(String path, {String key, String secret}) async {
    final response = await get(
      "$baseUrl/$path",
      headers: await _prepareHeaders(key, secret, path),
    );

    return handleResponse(response);
  }

  //endregion

  Future<Map<String, String>> _prepareHeaders(String key, String secret, String path) async {
    final credentials = await _prefs.getCredentials();
    if (key == null || secret == null) {
      key = credentials.key;
      secret = credentials.secret;
    }
    return headers(key: key, secret: secret, path: path, body: "{}");
  }

}
