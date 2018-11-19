import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/tickers/tickers_state.dart';

class TickersBloc extends ShiffrBloc<dynamic, TickersState> {
  
  final _api = BitfinexApiV2();

  @override
  get initialState => TickersState(status: ShiffrStatus.LOADING);

  @override
  void start() {
    loadTickers();
  }

  void loadTickers() async {
    try {
      final tickers = await _api.getTradingTickers();
      dispatch(TickersState(status: ShiffrStatus.DATA, viewModel: TickersViewModel(tickers)));
    } catch (socketException) {
      print("exception: ${socketException.toString()}");
      dispatch(TickersState(status: ShiffrStatus.ERROR));
    }
  }

}
