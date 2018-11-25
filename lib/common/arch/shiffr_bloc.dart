import 'package:bloc/bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';

abstract class ShiffrBloc<S extends ShiffrState> extends Bloc<dynamic, S> {
  void start();

  @override
  Stream<S> mapEventToState(state, event) async* {
    if (event is S) {
      yield event;
    } else {
      throw Exception("Unknown event type");
    }
  }
}
