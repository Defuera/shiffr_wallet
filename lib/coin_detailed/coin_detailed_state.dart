import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_ticker.dart';

class CoinDetailedState extends ShiffrState<CoinDetailedViewModel> {
  CoinDetailedState.loading() : super(status: ShiffrStatus.LOADING);
  CoinDetailedState.data({ticker}): super(status: ShiffrStatus.DATA, viewModel: CoinDetailedViewModel(ticker),);
  CoinDetailedState.error() : super(status: ShiffrStatus.ERROR);
}

class CoinDetailedViewModel {
  final Ticker ticker;

  CoinDetailedViewModel(this.ticker);
}
