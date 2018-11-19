enum ShiffrStatus { LOADING, DATA, ERROR, NETWORK_ERROR }

class ShiffrState<VM> {
  final ShiffrStatus status;
  final VM viewModel;

  ShiffrState({this.status: ShiffrStatus.LOADING, this.viewModel});

  factory ShiffrState.loading() {
    return ShiffrState(status: ShiffrStatus.LOADING);
  }

  factory ShiffrState.dataLoaded(int tabIndex, VM viewModel) {
    return ShiffrState(status: ShiffrStatus.DATA, viewModel: viewModel);
  }

  factory ShiffrState.error() {
    return ShiffrState(status: ShiffrStatus.ERROR);
  }
}
