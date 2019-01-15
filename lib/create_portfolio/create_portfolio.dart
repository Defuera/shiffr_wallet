import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_page_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';
import 'package:shiffr_wallet/common/navigation_helper.dart';
import 'package:shiffr_wallet/create_portfolio/create_cold_wallet_portfolio.dart';

class CreatePortfolioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreatePortfolioPageState();
  }
}

class _CreatePortfolioPageState extends ShiffrPageState {
  final bloc = _CreatePortfolioPageBloc();

  @override
  createBloc<B>(BuildContext context) => _CreatePortfolioPageBloc();

  @override
  getDataView(viewModel) {
    return _buildListPortfolios(["Cold wallet", "Exchange", "Hot wallet", "Custom"]);
  }

  @override
  String getTitle(BuildContext context) {
    return "Add portfolio";
  }

  _buildListPortfolios(List<String> portfolioOptions) {
    return ListView.builder(
      itemCount: portfolioOptions.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => itemTapped(context, index),
          child: Card(
            child: Container(
              height: 68.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    portfolioOptions[index],
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  itemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        navigateTo(context, CreateColdWalletPortfolio());
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}

class _CreatePortfolioPageBloc extends Bloc<dynamic, PageState> {
  @override
  PageState get initialState => PageState.data(null);

  @override
  Stream<PageState> mapEventToState(PageState state, event) {
    return null;
  }
}

class PageState extends ShiffrState<ViewModel> {
  PageState.loading() : super(status: ShiffrStatus.LOADING);

  PageState.data(ViewModel viewModel) : super(status: ShiffrStatus.DATA, viewModel: viewModel);

  PageState.error() : super(status: ShiffrStatus.ERROR);
}

class ViewModel {}
