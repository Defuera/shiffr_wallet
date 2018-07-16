import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shiffr_wallet/app/model/balance.dart';
import 'package:shiffr_wallet/app/preferences.dart';

import 'package:crypto/crypto.dart';

class BitfinexApiV1 {
  final _preferences = Preferences();

  final baseUrl = "https://api.bitfinex.com";
  final endpointBalances = "/v1/balances";

  Future<List<Balance>> getBalances(String key, String secret) async {
    print("key $key");
    final response = await get(
        "$baseUrl/$endpointBalances",
//        headers: headers(),
    );
    var map = json.decode(response.body);
//    return Balance.fromJson(map)
    print("response: $map");
    return BalanceList
        .fromJson(map)
        .balances;
  }


  //region Headers

//  def _headers(self, path, nonce, body):
//
//        signature = "/api/" + path + nonce + body
//        print "Signing: " + signature
//        h = hmac.new(self.SECRET.encode('utf8'), signature.encode('utf8'), hashlib.sha384)
//        signature = h.hexdigest()
//
//        return {
//          "bfx-nonce": nonce,
//          "bfx-apikey": self.KEY,
//          "bfx-signature": signature,
//          "content-type": "application/json"
//        }

  //endregion

//  Map<String, String> headers(String secret, path, nonce, body) {
//    var signature = "/api/" + path + nonce + body;
//    print ("Signing: " + signature);
//    final h = hmac.new(secret.encode('utf8'), signature.encode('utf8'), hashlib.sha384);
//    signature = h.hexdigest();
//
//    return {
//      "X-BFX-APIKEY": key,
//      "X-BFX-PAYLOAD": getPayload(),
//      "X-BFX-SIGNATURE": getSignature(secret),
//    }
//  }

  String getPayload() {
    return "payload";
  }

  String getSignature(String secret) {
    var key = utf8.encode(secret);
    var hmacSha256 = new Hmac(sha256, key);
    return "signature";
  }


}

