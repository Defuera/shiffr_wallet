class Wallet {
  WalletType type; //":"deposit",
  String currency; //":"btc",
  double amount; //":"0.0",
  double unsettledInterest; //":"0.0",
  double available; //":"0.0"

  Wallet({this.type, this.currency, this.amount, this.unsettledInterest, this.available});

  factory Wallet.fromJsonArray(List<dynamic> jsonList) => Wallet(
      type: WalletType.values.firstWhere((item) {
        var typeString = jsonList[0];
        return item.toString().replaceRange(0, 11, "") == typeString;
      }),
      currency: jsonList[1],
      amount: parseNullableDouble(jsonList[2]),
      unsettledInterest: parseNullableDouble(jsonList[3]),
      available: parseNullableDouble(jsonList[4]));

  static double parseNullableDouble(value) {
    if (value == null) {
      return null;
    } else {
      return value.toDouble();
    }
  }

  @override
  String toString() {
    return "[$type, $currency, $amount]";
  }

}

enum WalletType { exchange, margin, funding }

class WalletList {
  List<Wallet> balances;

  WalletList({this.balances});

  factory WalletList.fromJson(List<dynamic> json) =>
      WalletList(balances: (json.map((i) => Wallet.fromJsonArray(i)).toList()));
}
