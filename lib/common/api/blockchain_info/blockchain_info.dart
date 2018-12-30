import 'package:http/http.dart' as httpClient;
import 'dart:async';
import 'dart:convert';

import 'package:shiffr_wallet/common/api/response_handling_utils.dart';

const _base_url = "https://blockchain.info";
const _address_info = "rawaddr";
//https://blockchain.info/rawaddr/1EBHA1ckUWzNKN7BMfDwGTx6GKEbADUozX
class BlockchainInfoApi {

  Future<String> getAddressInfo() async {
    final response = await httpClient.get("$_base_url/$_address_info");
    final responseBody = handleResponse(response);
//    return jsonResponse.de["final_balance"];
    var jsonObject = await json.decode(responseBody);
    return jsonObject["final_balance"];
  }
}

class AddressInfo {

}