//import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
//import 'package:shiffr_wallet/detailed/coin_detailed_page.dart';
//
//class DetailedPresenter {
//  final _api = BitfinexApiV2();
//
//  final DetailedPageState _pageState;
//  final String _pair;
//
//  DetailedPresenter(this._pageState, this._pair);
//
//  void start() {
//    loadPairOrders();
//  }
//
//  void loadPairOrders() async {
//    _pageState.showLoading();
//
//    try {
//      var data = await _api.getListOrders(_pair);
//
//      print("loadListPairs: $data");
//
////      _pageState.showData(data);
//    } catch (SocketException) {
//      _pageState.showError();
//    }
//  }
//}
