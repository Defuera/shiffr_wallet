import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_page_state.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/common/widgets/ticker_widget.dart';
import 'package:shiffr_wallet/create_portfolio/create_portfolio.dart';
import 'package:shiffr_wallet/generated/i18n.dart';
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
  String getTitle(BuildContext context) {
    return S.of(context).tickers_page_title;
  }

  @override
  getDataView(viewModel) {
    var tapBarPages = buildTapBarPages(viewModel);
    return DefaultTabController(
      length: tapBarPages.length,
      child: TabBarView(
        children: tapBarPages,
      ),
    );
  }

  List<Widget> buildTapBarPages(TickersViewModel viewModel) {
    return <Widget>[
      ListView.builder(
        itemCount: viewModel.tickers.length + (viewModel.displayCreatePortfolio ? 1 : 0),
        itemBuilder: (context, index) {
          if (viewModel.displayCreatePortfolio && index == 0) {
            return _buildCreatePortfolioWidget(context);
          }
          return TickerWidget(viewModel.tickers[index]);
        },
      ),
      Container(
        color: Colors.purple,
      )
    ];
  }

  Widget _buildCreatePortfolioWidget(BuildContext context) {
    return Container(
      height: 68.0,
      child: Card(
        child: Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () => navigateTo(context, CreatePortfolioPage()),
            child: Text(S.of(context).tickers_page_add_portfolio),
          ),
        ),
      ),
    );
  }
}
