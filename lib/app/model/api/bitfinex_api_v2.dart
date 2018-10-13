import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:shiffr_wallet/app/model/api_error.dart';
import 'package:shiffr_wallet/app/model/model_ticker.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/app/preferences.dart';

class BitfinexApiV2 {
  final _prefs = Preferences();

  //authenticated endpoints
  final baseUrl = "https://api.bitfinex.com";
  final pathWallets = "v2/auth/r/wallets";
  final pathOrdersByPair = "v2/auth/r/orders";

  //not auth endpoints
  final pathTicker = "v2/tickers?symbols=";

  Future<List<Wallet>> getWalletsToLogin(String key, String secret) async {
    var responseString = await _executePost(pathWallets, key: key, secret: secret);
//    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<List<Wallet>> getWallets() async {
    var responseString = await _executePost(pathWallets);
//    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<List<Ticker>> getTradingTickers(List<String> pairs) async { //todo do not need to be signed, since not authenticated endpoint, so stop loosing processing power
//    print("getTradingTicker pair: $pair");
    var pathArgs = "";
    pairs.forEach((pair) {
      pathArgs += "t$pair,";
    });
    final responseString = await _executeGet("$pathTicker$pathArgs");
//    print("getTradingTicker response: $responseString");
    final map = await json.decode(responseString);

    return TickerList.fromJson(map).tickers;
  }

  Future<List<Wallet>> getListOrders(String pair) async {
    var responseString = await _executePost("$pathOrdersByPair/$pair");
//    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  //region helper methods

  _executePost(String path, {String key, String secret}) async {
    final credentials = await _prefs.getCredentials();
    if (key == null || secret == null) {
      key = credentials.key;
      secret = credentials.secret;
    }

    final response = await post(
      "$baseUrl/$path",
      headers: _headers(key: key, secret: secret, path: path, nonce: _getNonce(), body: "{}"),
    );

    if (isSuccess(response.statusCode)) {
      return response.body;
    } else {
      throw ApiError(response.statusCode, response.body);
    }
  }

  _executeGet(String path, {String key, String secret}) async {
    final credentials = await _prefs.getCredentials();
    if (key == null || secret == null) {
      key = credentials.key;
      secret = credentials.secret;
    }

    final response = await get(
      "$baseUrl/$path",
      headers: _headers(key: key, secret: secret, path: path, nonce: _getNonce(), body: "{}"),
    );

    if (isSuccess(response.statusCode)) {
      return response.body;
    } else {
      throw ApiError(response.statusCode, response.body);
    }
  }

  bool isSuccess(int statusCode) => statusCode >= 200 && statusCode < 300;

  Map<String, String> _headers({String key, String secret, String path, int nonce, String body}) {
    return {
      'Content-type': 'application/json',
      "bfx-nonce": nonce.toString(),
      "bfx-apikey": key,
      "bfx-signature": _calculateSignature(secret, path, nonce)
    };
  }

  String _calculateSignature(String secret, String path, int nonce) {
    var keyBytes = utf8.encode(secret);

    final signature = "/api/" + path + nonce.toString(); // + body;
    final signatureBytes = utf8.encode(signature);

    final hmacProvider = HMac(SHA384Digest(), 128);
    hmacProvider.init(KeyParameter(keyBytes));
    hmacProvider.reset();
    hmacProvider.update(signatureBytes, 0, signatureBytes.length);

    var output = Uint8List(hmacProvider.macSize);
    hmacProvider.doFinal(output, 0);
    return hex.encode(output);
  }

  _getNonce() => DateTime.now().millisecondsSinceEpoch;

//endregion

}
