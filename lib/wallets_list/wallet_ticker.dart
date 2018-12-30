
import 'package:shiffr_wallet/common/api/bitfinex/models/model_ticker.dart';
import 'package:shiffr_wallet/common/api/bitfinex/models/model_wallet.dart';

class WalletTicker {
  final String symbol;
  final Wallet wallet;
  final Ticker ticker;

  WalletTicker({this.symbol,  this.wallet, this.ticker});
}