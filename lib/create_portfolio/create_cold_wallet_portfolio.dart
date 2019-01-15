import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shiffr_wallet/common/arch/shiffr_page_state.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';

class CreateColdWalletPortfolio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateColdWalletPortfolioPageState();
  }
}

class _CreateColdWalletPortfolioPageState extends ShiffrPageState<CreateColdWalletPortfolio, _State, _CreateColdWalletPortfolioBloc> {
  @override
  createBloc<B>(BuildContext context) {
    return _CreateColdWalletPortfolioBloc();
  }

  @override
  getDataView(viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          TextField(
//          controller: _apiKeyController,
            decoration: InputDecoration(
              labelText: "Input address",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {},
              child: Text("Add address"),
            ),
          )
        ],
      ),
    );
  }

  @override
  String getTitle(BuildContext context) {
    return "New cold wallet";
  }
}

class _State extends ShiffrState<_ViewModel> {
  _State.initial() : super(status: ShiffrStatus.DATA);
}

class _ViewModel {}

class _CreateColdWalletPortfolioBloc extends Bloc<dynamic, _State> {
  @override
  _State get initialState => _State.initial();

  @override
  Stream<_State> mapEventToState(_State state, event) {
    return null;
  }

}
