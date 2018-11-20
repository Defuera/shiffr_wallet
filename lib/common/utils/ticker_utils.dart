

String retrieveQuoteCurrency(String tickerPair) => tickerPair.substring(1, tickerPair.length - 3);

String retrieveBaseCurrency(String tickerPair) => tickerPair.substring(tickerPair.length - 3, tickerPair.length);