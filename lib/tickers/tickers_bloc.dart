import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';
import 'package:shiffr_wallet/common/utils/ticker_utils.dart';
import 'package:shiffr_wallet/tickers/tickers_state.dart';

const _MIN_MARKET_CAP_TO_DISPLAY = 50000;

class TickersBloc extends ShiffrBloc<TickersState> {
  final _api = BitfinexApiV2();

  @override
  get initialState => TickersState.loading();

  @override
  void start() {
    loadTickers();
  }

  void loadTickers() async {
    try {
      final tickers = await _api.getTradingTickers();
      final List<Ticker> filteredTickers = tickers
          .where((it) => it.symbol.startsWith("t"))
          .where((it) => retrieveBaseCurrency(it.symbol) == "USD") //todo inject base currency
          .where((it) => it.marketCap() > _MIN_MARKET_CAP_TO_DISPLAY)
          .toList();

      filteredTickers.sort((a, b) => b.marketCap().compareTo(a.marketCap()));
      print("size: ${filteredTickers.length}");

      dispatch(TickersState.data(TickersViewModel(filteredTickers)));
    } catch (exception, stacktrace) {
      print("exception: ${exception.toString()}");
      print(stacktrace.toString());
      dispatch(TickersState.error());
    }
  }
}
