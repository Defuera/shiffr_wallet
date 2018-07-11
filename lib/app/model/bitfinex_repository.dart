import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:shiffr_wallet/app/model/balance.dart';

class BitfinexRepository {
  final baseUrl = "https://api.bitfinex.com/v1/";
  final endpointBalances = "balances";

  Future<List<Balance>> getBalances() async {
    final response = await get("$baseUrl/$endpointBalances");
    var map = json.decode(response.body);
//    return Balance.fromJson(map)
    print("response: $map");
    return BalanceList.fromJson(map).balances;
  }


}

