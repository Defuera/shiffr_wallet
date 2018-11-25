import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_widget_state.dart';
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/model/model_candle.dart';
import 'package:shiffr_wallet/common/model/repos/candle_repository.dart';


class CurrencyChart extends StatefulWidget {
  final String _coin;

  CurrencyChart(this._coin);

  @override
  State<StatefulWidget> createState() {
    return _CurrencyChartWidgetState(_coin);
  }
}

class _CurrencyChartWidgetState extends ShiffrWidgetState<CurrencyChart, CurrencyChartState, _CurrencyChartBloc> {
  final String _coin;

  _CurrencyChartWidgetState(this._coin);

  @override
  createBloc<B>(BuildContext context) {
    return _CurrencyChartBloc(_coin);
  }

  @override
  getDataView(viewModel) {
    List<Candle> candles = viewModel;

    final List<Series<Candle, DateTime>> seriesList = List.of([
      Series(
//        id: "0",
        data: candles,
        domainFn: (Candle candle, int index) => DateTime.fromMillisecondsSinceEpoch(candle.timestamp),
        measureFn: (Candle candle, int index) => candle.close,
      )
    ]);
    return Container(
      height: 200.0,
      child: TimeSeriesChart(seriesList),
    );
  }
}

class TestData {
  DateTime dateTime;
  int value;

  TestData(this.dateTime, this.value);
}

class CurrencyChartState extends ShiffrState<List<Candle>> {
  CurrencyChartState.loading() : super(status: ShiffrStatus.LOADING);

  CurrencyChartState.data(List<Candle> candles) : super(status: ShiffrStatus.DATA, viewModel: candles);
}

class ViewModel {}

class _CurrencyChartBloc extends ShiffrBloc<CurrencyChartState> {
  final String _coin;

  final _repository = CandleRepository(BitfinexApiV2());
  _CurrencyChartBloc(this._coin);

  @override
  CurrencyChartState get initialState => CurrencyChartState.loading();

  @override
  start() {
    loadCandles();
  }

  void loadCandles() async {
    try {
      final candles = await _repository.getCandles(symbol: _coin, baseCurrency: "USD"); //todo inject
      dispatch(CurrencyChartState.data(candles));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace);
    }
  }
}
