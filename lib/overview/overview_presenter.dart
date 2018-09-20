import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/app/repository_bitfinex.dart';
import 'package:shiffr_wallet/detailed/page_detailed.dart';
import 'package:shiffr_wallet/overview/overview_page.dart';

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

  void navigateTo(BuildContext context, String pair) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => DetailedPage(pair)),
    );
  }
}
