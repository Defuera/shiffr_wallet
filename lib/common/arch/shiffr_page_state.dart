import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiffr_wallet/app/app_bloc.dart';
import 'package:shiffr_wallet/common/arch/lifecycle_events.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';

abstract class ShiffrPageState<
    T extends StatefulWidget,
    S extends ShiffrState,
    B extends Bloc<dynamic, S>
  > extends State<T> {

  ApplicationBloc appBloc;
  B bloc;

  createBloc<B>(BuildContext context);

  @override
  void dispose() {
    bloc.dispatch(LifecycleEvent.DESTROY);
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
      bloc.dispatch(LifecycleEvent.START);
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
              title: Text(getTitle(context), style: Theme.of(context).textTheme.title),
              actions: getAppBarActions(context),
            ),
            body: widget,
            bottomNavigationBar: buildBottomNavigationBar(context, state),
          );
        });
  }

  String getTitle(BuildContext context);

  getDataView(viewModel);

  Widget getLoadingView() => Center(child: CircularProgressIndicator());

  Widget getErrorView() => GestureDetector(
        child: Center(
          child: Text("Network error, try again later"),
        ),
        onTap: () => bloc.dispatch(LifecycleEvent.START),
      );

  BottomNavigationBar buildBottomNavigationBar(BuildContext context, S state) => null;

  List<Widget> getAppBarActions(BuildContext context) => null;
}
