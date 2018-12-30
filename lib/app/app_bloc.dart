import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/api/bitfinex/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/tickers/tickers_page.dart';

class ApplicationBloc extends Bloc {
  var _appState = _AppState();

  @override
  get initialState => _appState;

  @override
  Stream mapEventToState(state, event) async* {}

  logout(BuildContext context) {
    _appState = _AppState(isLoggedIn: false);
    navigateTo(context, TickersPage());
  }


  //region injector

  getBaseCurrency() => "USD";

  getApi() => BitfinexApiV2();

  //endregion

}

class _AppState {
  final bool isLoggedIn;

  _AppState({this.isLoggedIn});
}
