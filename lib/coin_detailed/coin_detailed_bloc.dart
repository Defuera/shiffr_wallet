import 'package:bloc/bloc.dart';
import 'package:shiffr_wallet/coin_detailed/coin_detailed_interactor.dart';
import 'package:shiffr_wallet/coin_detailed/coin_detailed_state.dart';
import 'package:shiffr_wallet/common/arch/lifecycle_events.dart';
import 'package:shiffr_wallet/common/api/bitfinex/bitfinex_api_v2.dart';

class CoinDetailedBloc extends Bloc<dynamic, CoinDetailedState> {
  final String _symbol;
  final String _baseCurrency;
  final BitfinexApiV2 _api;
  CoinDetailedInteractor _interactor;

  var ticker;
  var candles;

  @override
  Stream<CoinDetailedState> mapEventToState(state, event) async* {
    if (event == LifecycleEvent.START) {
      final state = await loadTicker();
      yield state;
    } else {
      throw Exception("Unknown event type");
    }
  }

  CoinDetailedBloc(this._symbol, this._baseCurrency, this._api) {
    _interactor = CoinDetailedInteractor(_api);
  }

  @override
  CoinDetailedState get initialState => CoinDetailedState.loading();

  Future<CoinDetailedState> loadTicker() async {
    try {
      ticker = await _interactor.getTicker(_symbol, _baseCurrency);
      return CoinDetailedState.data(ticker: ticker);
    } catch (error) {
      print(error.toString());
      return CoinDetailedState.error();
    }
  }

}
