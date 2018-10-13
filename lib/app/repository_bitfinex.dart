import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

const BASE_URL = "https://api.bitfinex.com";

@deprecated
class BitfinexRepository {

  Future<List<String>> getSymbols() async {
    final url = "$BASE_URL/v1/symbols";

    try {
      final response = await get(url);

      final List<dynamic> parsedJson = json.decode(response.body);
      final responseJson = parsedJson.cast<String>();

      return responseJson;
    } catch (exception) {
      print(exception.toString());

      return Future.error(exception);
    }
  }

}
