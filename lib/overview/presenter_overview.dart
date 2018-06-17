import 'dart:async';

import 'package:shiffr_wallet/app/repository_bitfinex.dart';
import 'package:shiffr_wallet/overview/page_overview.dart';

class OverviewPresenter {
  final _repository = BitfinexRepository();

  final OverviewPageState _overviewPageState;

  OverviewPresenter(this._overviewPageState);

  void start() {
    loadListPairs();
  }

  void loadListPairs() async {
    _overviewPageState.showLoading();

    try {
      var data = await _repository.getSymbols();
      await new Future.delayed(
          const Duration(milliseconds: 400)); //todo remove, it's only for debug

      print("loadListPairs: $data");

      _overviewPageState.showData(data);
    } catch (SocketException) {
      _overviewPageState.showError();
    }
  }
}
