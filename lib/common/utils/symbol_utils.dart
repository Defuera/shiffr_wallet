String symbolToTicker(String symbol) {
  switch (symbol) {
    case "BTC":
      return "Bitcoin";

    case "ETH":
      return "Ethereum";

    case "ETC":
      return "Ethereum classic";

    case "BAB":
      return "Bitcoin cache";

    case "BSV":
      return "Bitcoin cache2";

    case "XRP":
      return "Ripple";

    case "LTC":
      return "Litecoin";

    case "DSH":
      return "Dash";

    case "OMG":
      return "Omnise go";

    case "BTG":
      return "Bitcoin gold";

    case "":
      return "";

    case "":
      return "";

    case "":
      return "";

    case "":
      return "";

    case "":
      return "";

    default:
      return symbol;
  }
}
