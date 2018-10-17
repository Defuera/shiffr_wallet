class Order {
//  ID,ID	int64	Order ID
//GID	int	Group ID
//CID	int	Client Order ID
//SYMBOL	string	Pair (tBTCUSD, …)
//MTS_CREATE	int	Millisecond timestamp of creation
//MTS_UPDATE	int	Millisecond timestamp of update
//AMOUNT	float	Remaining amount.
//AMOUNT_ORIG	float	Original amount, positive means buy, negative means sell.
//TYPE	string	The type of the order: LIMIT, MARKET, STOP, TRAILING STOP, EXCHANGE MARKET, EXCHANGE LIMIT, EXCHANGE STOP, EXCHANGE TRAILING STOP, FOK, EXCHANGE FOK.
//TYPE	string	Previous order type
//FLAGS	int	Upcoming Params Object (stay tuned)
//ORDER_STATUS	string	Order Status: ACTIVE, EXECUTED, PARTIALLY FILLED, CANCELED
//PRICE	float	Price
//PRICE_AVG	float	Average price
//PRICE_TRAILING	float	The trailing price
//PRICE_AUX_LIMIT	float	Auxiliary Limit price (for STOP LIMIT)
//NOTIFY	int	1 if Notify flag is active, 0 if not
//HIDDEN	int	1 if Hidden, 0 if not hidden
//PLACED_ID	int	If another order caused this order to be placed (OCO) this will be that other order's ID

  final int id;
  final int groupId;
  final int clientOrderId;
  final String symbol;
  final int creationTimestamp;
  final int updateTimestamp;
  final double amount;
  final double amountOriginal;
  final String orderStatus;
  final double price;
  final double priceAverage;
  final double priceTrailing;
  final double priceAuxLimit;
  final bool notify;
  final bool hidden;
  final int placeId;

  Order(
      {this.id,
      this.groupId,
      this.clientOrderId,
      this.symbol,
      this.creationTimestamp,
      this.updateTimestamp,
      this.amount,
      this.amountOriginal,
      this.orderStatus,
      this.price,
      this.priceAverage,
      this.priceTrailing,
      this.priceAuxLimit,
      this.notify,
      this.hidden,
      this.placeId});

  factory Order.fromJsonArray(List<dynamic> jsonList) {
    print(jsonList);
    var order = Order(
      id: jsonList[0],
      groupId: jsonList[1],
      clientOrderId: jsonList[2],
      symbol: jsonList[3],
      creationTimestamp: jsonList[4],
      updateTimestamp: jsonList[5],
      amount: jsonList[6],
      amountOriginal: jsonList[7],
      orderStatus: jsonList[8],
      price: jsonList[9],
      priceAverage: jsonList[10],
      priceTrailing: jsonList[11],
      priceAuxLimit: jsonList[12],
      notify: jsonList[13],
      hidden: jsonList[14],
      placeId: jsonList[15],
    );
//    print(order);
    return order;
  }

//  @override
//  String toString() {
//    return "[$type, $currency, $amount]";
//  }
}

class OrderList {
  List<Order> orders;

  OrderList({this.orders});

  factory OrderList.fromJson(List<dynamic> json) =>
      OrderList(orders: (json.map((i) => Order.fromJsonArray(i)).toList()));
}
