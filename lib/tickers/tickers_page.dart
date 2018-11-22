import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_page_state.dart';
import 'package:shiffr_wallet/common/widgets/ticker_widget.dart';
import 'package:shiffr_wallet/tickers/tickers_bloc.dart';
import 'package:shiffr_wallet/tickers/tickers_state.dart';

class TickersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TickersPageState();
  }
}

class _TickersPageState extends ShiffrPageState<TickersPage, TickersState, TickersBloc> {
  @override
  createBloc<B>(BuildContext context) {
    return TickersBloc();
  }

  @override
  String getTitle() {
    return "Tickers";
  }

  @override
  getDataView(TickersState state) {
    var tapBarPages = buildTapBarPages(state);
    return DefaultTabController(
      length: tapBarPages.length,
      child: TabBarView(
        children: tapBarPages,
      ),
    );
  }

  List<Widget> buildTapBarPages(TickersState state) {
    return <Widget>[
      ListView.builder(
        itemCount: state.viewModel.tickers.length,
        itemBuilder: (context, index) {
          return TickerWidget(state.viewModel.tickers[index]);
        },
      ),
      Container(
        color: Colors.purple,
      )
    ];
  }
}
