import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

const BASE_URL = "https://api.bitfinex.com";

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



//      if (response.statusCode == HttpStatus.OK) {
//        var json = await response.transform(utf8.decoder).join();
//        List data = JSON.decode(json);
//
//        return data;
//      } else {
//        print("Failed http call."); // Perhaps handle it somehow
//      }
//    } catch (exception) {
//      print(exception.toString());
//    }
//    return null;
  }
}
