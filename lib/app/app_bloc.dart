import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/tickers/tickers_page.dart';

class ApplicationBloc extends Bloc {
  var _appState = _AppState();

  @override
  get initialState => _appState;

  @override
  Stream mapEventToState(state, event) {
//    if (event is _AppState) {
//      if (_appState.isLoggedIn != event.isLoggedIn){
//        _appState = event;
//        _performLogout();
//      }
//      return Stream.fromFuture(Future.value(event));
//    } else {
//      throw Exception("unknown event");
//    }
  }

  logout(BuildContext context) {
//    dispatch(_AppState(isLoggedIn: false));
    _appState = _AppState(isLoggedIn: false);
    navigateAsNewRoot(context, TickersPage());
//    Navigator.of(context).removeRoute(MaterialPageRoute(builder: (context) => ));
  }

  void _performLogout() {

  }
}

class _AppState {
  final bool isLoggedIn;

  _AppState({this.isLoggedIn});
}
