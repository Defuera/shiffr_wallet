class Balance {
  BalanceType type; //":"deposit",
  String currency; //":"btc",
  int amount; //":"0.0",
  int available; //":"0.0"

  Balance({this.type, this.currency, this.amount, this.available});

  factory Balance.fromJson(Map<String, dynamic> jsonMap) => Balance(
      type: BalanceType.values.firstWhere((item) => item.toString() == jsonMap["type"]),
      currency: jsonMap["currency"],
      amount: jsonMap["amount"],
      available: jsonMap["available"]);
}

enum BalanceType { deposit, exchange, trading }

class BalanceList {
  List<Balance> balances;

  BalanceList({this.balances});

  factory BalanceList.fromJson(List<dynamic> json) =>
      BalanceList(balances: (json.map((i) => Balance.fromJson(i)).toList()));
}
