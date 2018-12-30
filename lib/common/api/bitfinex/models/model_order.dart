class Order {
  final int id; //0  ID
  final int groupId; //1  GID
  final int clientOrderId; //2  CID
  final String symbol; //3 SYMBOL
  final int creationTimestamp; //4  MTS_CREATE
  final int updateTimestamp; //5  MTS_UPDATE
  final double amount; //6  AMOUNT
  final double amountOriginal; //7  AMOUNT_ORIG

  /// The type of the order: LIMIT, MARKET, STOP, TRAILING STOP, EXCHANGE MARKET, EXCHANGE LIMIT, EXCHANGE STOP, EXCHANGE TRAILING STOP, FOK, EXCHANGE FOK.
  final String type; //8  TYPE,

  final String typePrev; //9  TYPE_PREV
  final int flags; //12  FLAGS
  final String orderStatus; //13  STATUS
  final double price; //16  PRICE
  final double priceAverage; //17  PRICE_AVG
  final double priceTrailing; //18  PRICE_TRAILING
  final double priceAuxLimit; //19  PRICE_AUX_LIMIT
  final bool hidden; //23  HIDDEN
  final int placeId; //24  PLACED_ID

  Order(
      {this.id,
      this.groupId,
      this.clientOrderId,
      this.symbol,
      this.creationTimestamp,
      this.updateTimestamp,
      this.amount,
      this.amountOriginal,
      this.type,
      this.typePrev,
      this.flags,
      this.orderStatus,
      this.price,
      this.priceAverage,
      this.priceTrailing,
      this.priceAuxLimit,
      this.hidden,
      this.placeId});

  factory Order.fromJsonArray(List<dynamic> jsonList) => Order(
        id: _parseValue(jsonList, 0),
        groupId: _parseValue(jsonList, 1),
        clientOrderId: _parseValue(jsonList, 2),
        symbol: _parseValue(jsonList, 3),
        creationTimestamp: _parseValue(jsonList, 4),
        updateTimestamp: _parseValue(jsonList, 5),
        amount: _parseValue(jsonList, 6, converter: _toDouble),
        amountOriginal: _parseValue(jsonList, 7, converter: _toDouble),
        type: _parseValue(jsonList, 8),
        typePrev: _parseValue(jsonList, 9),
        flags: 0,
        orderStatus: _parseValue(jsonList, 13),
        price: _parseValue(jsonList, 16, converter: _toDouble),
        priceAverage: _parseValue(jsonList, 17, converter: _toDouble),
        priceTrailing: _parseValue(jsonList, 18, converter: _toDouble),
        priceAuxLimit: _parseValue(jsonList, 19, converter: _toDouble),
        hidden: _parseValue(jsonList, 23, converter: _intToBool),
        placeId: _parseValue(jsonList, 24),
      );

  static _intToBool(int val) => val == 1;

  static _toDouble(dynamic x) {
    if (x == null) {
      return null;
    } else {
      return x.toDouble();
    }
  }

  static dynamic _parseValue(List<dynamic> jsonList, int index, {Function converter}) {
      final value = jsonList[index];
      if (converter != null) {
        return converter(value);
      } else {
        return value;
      }
  }

  @override
  String toString() {
    return "{$type, $symbol, $amount}";
  }
}

class OrderList {
  List<Order> orders;

  OrderList(this.orders);

  factory OrderList.fromJson(List<dynamic> json) => OrderList((json.map((i) => Order.fromJsonArray(i)).toList()));
}
