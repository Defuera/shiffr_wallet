import 'package:flutter/material.dart';
import 'package:shiffr_wallet/coin_detailed/coin_detailed_bloc.dart';
import 'package:shiffr_wallet/coin_detailed/coin_detailed_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_page_state.dart';
import 'package:shiffr_wallet/common/utils/symbol_utils.dart';
import 'package:shiffr_wallet/common/widgets/ticker_widget.dart';

class CoinDetailedPage extends StatefulWidget {
  final String _symbol;

  CoinDetailedPage(this._symbol);

  @override
  CoinDetailedPageState createState() {
    return CoinDetailedPageState(_symbol);
  }
}

enum Status { LOADING, DATA, ERROR }

class CoinDetailedPageState extends ShiffrPageState<CoinDetailedPage, CoinDetailedState, CoinDetailedBloc> {

  final String _symbol;

  CoinDetailedPageState(this._symbol);

  @override
  createBloc<B>(BuildContext context) {
    return CoinDetailedBloc(_symbol, appBloc.getBaseCurrency(), appBloc.getApi());
  }

  @override
  getDataView(viewModel) {

    return TickerWidget(viewModel.ticker);
  }

  @override
  String getTitle() {
    return symbolToTicker(_symbol);
  }

}
