import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:http/http.dart';
import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:shiffr_wallet/app/model/balance.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:pointycastle/pointycastle.dart';

//import 'package:crypto/crypto.dart';

class BitfinexApiV2 {
//  cipher: ^0.7.1

  final baseUrl = "https://api.bitfinex.com";
  final path = "v2/auth/r/wallets";

  Future<List<Balance>> getWallets(String apiKey, String secret) async {
    apiKey = "tO76VUSPfL2fyTelZUeotygavdjvAZVYqkEOwB3Eh5P";
    secret = "8mAzJOmV2c2Eqk2AWeLnEbXGfrAtxBCKUJGGjcReywb";
    print("key $apiKey");
    final response = await post(
        "$baseUrl/$path",
        headers: headers(apiKey, secret, path, getNonce(), "{}"),
    );
    var responseString = response.body;
    print('responseString: $responseString');
    var map = json.decode(responseString);
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


//  Log.d(LOG_TAG, "generateHmac: " + key + "=" + message);
//  byte[] keyBytes = key.getBytes(ShapewaysClient.ENCODING);
//  byte[] data = message.getBytes(ShapewaysClient.ENCODING);
//
//  HMac macProvider = new HMac(new SHA1Digest());
//  macProvider.init(new KeyParameter(keyBytes));
//  macProvider.reset();
//
//  macProvider.update(data, 0, data.length);
//  byte[] output = new byte[macProvider.getMacSize()];
//  macProvider.doFinal(output, 0);
//
//  byte[] hmac = Base64.encode(output);
//  return new String(hmac).replaceAll("\r\n", "");


  Map<String, String> headers(String apiKey, String secret, String path, int nonce, String body) {
    var keyBytes = utf8.encode(secret);

    final signature = "/api/" + path + nonce.toString();// + body;
    final signatureBytes = utf8.encode(signature);

    print('signature bytes: $signatureBytes');

    final hmacProvider = HMac(SHA384Digest(), 128);
    hmacProvider.init(KeyParameter(keyBytes));
    hmacProvider.reset();

    hmacProvider.update(signatureBytes, 0, signatureBytes.length);

    var output  = Uint8List(hmacProvider.macSize);
    hmacProvider.doFinal(output, 0);

    var hmac = output.toString();
    print('hmac: $hmac');

    final hexString = hex.encode(output);

//    final encryptedSignature = hmac
//        .convert(encodedSecret)
//        .toString();


    return {
      'Content-type' : 'application/json',
      'Accept': 'application/json', //todo do I need that one?
      "bfx-nonce": nonce.toString(), //done
      "bfx-apikey": apiKey, //done
      "bfx-signature": hexString//encryptedSignature,  // getSignature(secret),
    };
  }

  String getPayload() {
    return "payload";
  }

//  String getSignature(String secret) {
//    var key = utf8.encode(secret);
//    var hmacSha256 = new Hmac(sha256, key);
//    return "signature";
//  }

  getNonce() {
    final nonce = DateTime.now().millisecondsSinceEpoch;
    return nonce;
  }


}

