import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_ticker.dart';

class TickersState extends ShiffrState<TickersViewModel> {

  TickersState.loading() : super(status: ShiffrStatus.LOADING);
  TickersState.data(TickersViewModel viewModel) : super(status: ShiffrStatus.DATA, viewModel: viewModel);
  TickersState.error() : super(status: ShiffrStatus.ERROR);
}

class TickersViewModel {
  final bool displayCreatePortfolio;
  final List<Ticker> tickers;

  TickersViewModel(this.displayCreatePortfolio, this.tickers);
}
