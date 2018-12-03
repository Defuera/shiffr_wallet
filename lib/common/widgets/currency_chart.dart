import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_widget_state.dart';
import 'package:shiffr_wallet/common/model/api/bitfinex_api_v2.dart';
import 'package:shiffr_wallet/common/model/model_candle.dart';
import 'package:shiffr_wallet/common/model/repos/candle_repository.dart';
import 'package:shiffr_wallet/common/widgets/chart_mode.dart';
import 'package:shiffr_wallet/common/widgets/custom_radio.dart';
import 'package:shiffr_wallet/common/widgets/paddings.dart';

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
  Widget getLoadingView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 200.0,
          child: Center(child: CircularProgressIndicator()),
        ),
        VerticalPadding(8.0),
        _buildRangeListRadios(null)
      ],
    );
  }

  @override
  getDataView(viewModel) {
    return Column(
      children: <Widget>[
        Container(
          height: 200.0,
          child: TimeSeriesChart(_createSeries(viewModel.candles)),
        ),
        VerticalPadding(8.0),
        _buildRangeListRadios(viewModel.chartMode),
      ],
    );
  }

  Widget _buildRangeListRadios(ChartMode selectedChartMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildRadio(ChartMode.ONE_HOUR, selectedChartMode),
        _buildRadio(ChartMode.ONE_DAY, selectedChartMode),
        _buildRadio(ChartMode.ONE_WEEK, selectedChartMode),
        _buildRadio(ChartMode.ONE_MONTH, selectedChartMode),
//        _buildRadio(ChartMode.ONE_YEAR, selectedChartMode),
//        _buildRadio(ChartMode.ALL_TIME, selectedChartMode),
      ],
    );
  }

  ChartRadio _buildRadio(ChartMode value, ChartMode groupValue) => ChartRadio(
        value: value,
        groupValue: groupValue,
        onChanged: (newChartMode) => bloc.onChartModeSelected(newChartMode),
      );

  List<Series<Candle, DateTime>> _createSeries(List<Candle> candles) => List.of([
        Series(
          id: "chart",
          data: candles,
          domainFn: (Candle candle, int index) => DateTime.fromMillisecondsSinceEpoch(candle.timestamp),
          measureFn: (Candle candle, int index) => candle.close,
        )
      ]);
}

class CurrencyChartState extends ShiffrState<ViewModel> {
  CurrencyChartState.loading() : super(status: ShiffrStatus.LOADING);

  CurrencyChartState.data(ViewModel viewModel) : super(status: ShiffrStatus.DATA, viewModel: viewModel);
}

class ViewModel {
  List<Candle> candles;
  ChartMode chartMode;

  ViewModel(this.candles, this.chartMode);
}

class _CurrencyChartBloc extends ShiffrBloc<CurrencyChartState> {
  final String _coin;
  final _repository = CandleRepository(BitfinexApiV2()); //todo inject
  final baseCurrency = "USD"; //todo inject

  ChartMode _chartMode = ChartMode.ONE_HOUR;

  _CurrencyChartBloc(this._coin);

  @override
  CurrencyChartState get initialState => CurrencyChartState.loading();

  @override
  start() {
    loadCandles();
  }

  void loadCandles() async {
    dispatch(CurrencyChartState.loading());
    try {
      final candles =
          await _repository.getCandles(symbol: _coin, baseCurrency: baseCurrency, timeFrame: _getTimeFrame());
      dispatch(CurrencyChartState.data(ViewModel(candles, _chartMode)));
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace);
    }
  }

  onChartModeSelected(ChartMode chartMode) {
    _chartMode = chartMode;
    loadCandles();
  }

  ///Available values: '1m', '5m', '15m', '30m', '1h', '3h', '6h', '12h', '1D', '7D', '14D', '1M'
  _getTimeFrame() {
    switch (_chartMode) {
      case ChartMode.ONE_HOUR:
        return "1h";
      case ChartMode.ONE_DAY:
        return "1D";
      case ChartMode.ONE_WEEK:
        return "7D";
      case ChartMode.ONE_MONTH:
        return "1M";
      case ChartMode.ONE_YEAR:
        return "12Y";
      case ChartMode.ALL_TIME:
        return "100M";
      default:
        throw Exception("unkhown chart mode");
    }
  }
}
