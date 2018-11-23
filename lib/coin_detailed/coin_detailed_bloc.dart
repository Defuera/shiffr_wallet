import 'package:shiffr_wallet/coin_detailed/coin_detailed_interactor.dart';
import 'package:shiffr_wallet/coin_detailed/coin_detailed_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';

class CoinDetailedBloc extends ShiffrBloc<CoinDetailedState> {
  final String _symbol;
  final String _baseCurrency;
  final BitfinexApiV2 _api;
  CoinDetailedInteractor _interactor;

  CoinDetailedBloc(this._symbol, this._baseCurrency, this._api) {
    _interactor = CoinDetailedInteractor(_api);
  }

  @override
  CoinDetailedState get initialState => CoinDetailedState.loading();

  @override
  start() {
    loadTicker();
//    loadCandles();
//    loadWallet();
  }

  void loadTicker() async {
    try {
      final ticker = await _interactor.getTicker(_symbol, _baseCurrency);
      dispatch(CoinDetailedState.data(ticker));
    } catch (error) {
      print(error.toString());
    }
  }
}
