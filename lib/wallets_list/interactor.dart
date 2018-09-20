import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';

class Interactor {

  final _api = BitfinexApiV2();

  getOverviewList(){

 }

  getWallets() => _api.getWallets();

}
