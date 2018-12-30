import 'dart:convert';

import 'package:pointycastle/digests/sha384.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'dart:typed_data';

import 'package:convert/convert.dart';

Map<String, String> headers({String key, String secret, String path, String body}) {
  final nonce = _getNonce();
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
