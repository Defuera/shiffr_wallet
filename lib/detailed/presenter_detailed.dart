import 'dart:async';

import 'package:shiffr_wallet/app/repository_bitfinex.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';

class DetailedPresenter {
  final _repository = BitfinexRepository();

  final DetailedPageState _pageState;

  DetailedPresenter(this._pageState);

  void start() {
    loadListPairs();
  }

  void loadListPairs() async {
//    _pageState.showLoading();
//
//    try {
//      var data = await _repository.getSymbols();
//      await new Future.delayed(
//          const Duration(milliseconds: 400)); //todo remove, it's only for debug
//
//      print("loadListPairs: $data");
//
//      _pageState.showData(data);
//    } catch (SocketException) {
//      _pageState.showError();
//    }
  }

}
