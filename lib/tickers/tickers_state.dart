import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/model/model_ticker.dart';

class TickersState extends ShiffrState<TickersViewModel> {

  TickersState({
    status: ShiffrStatus.LOADING,
    viewModel,
  }) : super(status: status, viewModel: viewModel);

}

class TickersViewModel {
  final List<Ticker> tickers;

  TickersViewModel(this.tickers);
}
