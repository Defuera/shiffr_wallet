
import 'package:shiffr_wallet/common/model/model_ticker.dart';
import 'package:shiffr_wallet/common/model/model_wallet.dart';

class WalletTicker {
  final String symbol;
  final Wallet wallet;
  final Ticker ticker;

  WalletTicker({this.symbol,  this.wallet, this.ticker});
}