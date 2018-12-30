import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';

abstract class ShiffrPageState<
    T extends StatefulWidget,
    S extends ShiffrState,
    B extends ShiffrBloc<S>
  > extends State<T> {

  ApplicationBloc appBloc;
  B bloc;

  createBloc<B>(BuildContext context);

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (appBloc == null) {
      appBloc = BlocProvider.of<ApplicationBloc>(context);
    }
    if (bloc == null) {
      bloc = createBloc(context);
      bloc.start();
    }

    var widget;

    return BlocBuilder<dynamic, S>(
        bloc: bloc,
        builder: (BuildContext context, S state,) {
          switch (state.status) {
            case ShiffrStatus.LOADING:
              widget = getLoadingView();
              break;
            case ShiffrStatus.DATA:
              widget = getDataView(state.viewModel);
              break;
            case ShiffrStatus.ERROR:
              widget = getErrorView(); //todo
              break;
            case ShiffrStatus.NETWORK_ERROR:
              widget = getErrorView();
              break;
          }

          return Scaffold(
            appBar: AppBar(
//              automaticallyImplyLeading: false,
              title: Text(getTitle(), style: Theme.of(context).textTheme.title),
              actions: getAppBarActions(context),
            ),
            body: widget,
            bottomNavigationBar: buildBottomNavigationBar(context, state),
          );
        });
  }

  String getTitle();

  getDataView(viewModel);

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getErrorView() => GestureDetector(
        child: Center(
          child: Text("Network error, try again later"),
        ),
        onTap: () => bloc.start(),
      );

  BottomNavigationBar buildBottomNavigationBar(BuildContext context, S state) => null;

  List<Widget> getAppBarActions(BuildContext context) => null;
}
