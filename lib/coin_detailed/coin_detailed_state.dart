import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';

class CoinDetailedState extends ShiffrState<CoinDetailedViewModel> {
  CoinDetailedState({
    ShiffrStatus status: ShiffrStatus.LOADING,
    CoinDetailedViewModel viewModel,
  }) : super(status: status, viewModel: viewModel);

  factory CoinDetailedState.loading() => CoinDetailedState(status: ShiffrStatus.LOADING);

  factory CoinDetailedState.data({ticker}) => CoinDetailedState(
        status: ShiffrStatus.DATA,
        viewModel: CoinDetailedViewModel(ticker),
      );
}

class CoinDetailedViewModel {
  final Ticker ticker;

  CoinDetailedViewModel(this.ticker);
}
