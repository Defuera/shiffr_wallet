import 'package:bloc/bloc.dart';
import 'package:shiffr_wallet/common/arch/shiffr_state.dart';

abstract class ShiffrBloc<E, S extends ShiffrState> extends Bloc<E, S> {
  start();

  @override
  Stream<S> mapEventToState(state, event) async* {
    if (event is S) {
      yield event;
    } else {
      throw Exception("Unknown event type");
    }
  }
}
