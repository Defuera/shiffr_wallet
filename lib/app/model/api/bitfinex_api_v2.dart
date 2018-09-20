import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:shiffr_wallet/app/model/model_ticker.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/app/preferences.dart';

class BitfinexApiV2 {
  final _prefs = Preferences();

  final baseUrl = "https://api.bitfinex.com";
  final pathWallets = "v2/auth/r/wallets";
  final pathTicker = "/v2/ticker/t";

  Future<List<Wallet>> getWalletsToLogin(String key, String secret) async {
    var responseString = await _executePost(pathWallets, key: key, secret: secret);
    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<List<Wallet>> getWallets() async {
    var responseString = await _executePost(pathWallets);
    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<Ticker> getTradingTicker(String pair) async {
    var responseString = await _executePost(pathTicker);
    print("getTradingTicker response: $responseString");
    var map = await json.decode(responseString);

    return Ticker.fromJson(map);
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

    return response.body;
  }

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
