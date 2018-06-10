import 'package:shiffr_wallet/app/repository_bitfinex.dart';

class OverviewPresenter {

  final _repository = BitfinexRepository();

  void start() {
    loadListPairs();
  }

  void loadListPairs() async {
    String data = await _repository.getSymbols();
    print(data);
  }

}
