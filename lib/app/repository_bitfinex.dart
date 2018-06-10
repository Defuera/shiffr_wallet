import 'dart:io';
import 'dart:async';

import 'dart:convert';

const BASE_URL = "https://api.bitfinex.com";

class BitfinexRepository {

  Future<List<String>> getSymbols() async {
    final url = "$BASE_URL/v1/symbols";
    final httpClient = new HttpClient();

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        List<String>  data = JSON.decode(json);

        return data;
      } else {
        print("Failed http call."); // Perhaps handle it somehow
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

}
