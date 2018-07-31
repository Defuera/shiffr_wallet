import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:shiffr_wallet/app/model/Wallet.dart';
import 'package:shiffr_wallet/app/preferences.dart';

class BitfinexApiV2 {

  final _prefs = Preferences();

  final baseUrl = "https://api.bitfinex.com";
  final pathWallets = "v2/auth/r/wallets";

  Future<List<Wallet>> getWalletsToLogin(String key, String secret) async {
    var responseString = await postMy(key, secret, pathWallets);
    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  Future<List<Wallet>> getWallets() async {
    final credentials = await _prefs.getCredentials();
    var responseString = await postMy(credentials.key, credentials.secret, pathWallets);
    print("getWallets response: $responseString");
    var map = await json.decode(responseString);

    return WalletList.fromJson(map).balances;
  }

  postMy(String key, String secret, String path) async {
    final response = await post(
      "$baseUrl/$path",
      headers: headers(
          key: key,
          secret: secret,
          path: path,
          nonce: getNonce(),
          body: "{}"),
    );

    return response.body;
  }

  Map<String, String> headers({String key, String secret, String path, int nonce, String body}) {
    return {
      'Content-type': 'application/json',
      "bfx-nonce": nonce.toString(),
      "bfx-apikey": key,
      "bfx-signature": calculateSignature(secret, path, nonce)
    };
  }

  String calculateSignature(String secret, String path, int nonce) {
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

  getNonce() => DateTime.now().millisecondsSinceEpoch;

}
