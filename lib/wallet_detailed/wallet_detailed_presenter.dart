import 'package:shiffr_wallet/app/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/app/model/model_wallet.dart';
import 'package:shiffr_wallet/wallet_detailed/wallet_detailed_page.dart';

class WalletDetailedPresenter {
  final _api = BitfinexApiV2();

  final WalletDetailedPageState _pageState;
  final Wallet _wallet;

  WalletDetailedPresenter(this._pageState, this._wallet);

  void start() {
    loadPairOrders();
  }

  void loadPairOrders() async {
    _pageState.showLoading();

    try {
      print("loadListPairs");
      var activeOrders = await _api.getActiveTradingListOrders(_wallet.currency, "USD");
      var historicOrders = await _api.getTradingListOrdersHistory(_wallet.currency, "USD");

//      print("loadListPairs: $data");

      _pageState.showData(activeOrders, historicOrders);
    } catch (exception) {
      print(exception);
      _pageState.showError();
    }
  }
}
