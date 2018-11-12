import 'package:shiffr_wallet/wallets_list/wallets_list_presenter.dart';

enum WalletListStatus { LOADING, DATA, ERROR } //todo naming is poor

class WalletListState {
  final WalletListStatus status;
  final int tabIndex;
  final ViewModel viewModel;

  const WalletListState({
    this.status: WalletListStatus.LOADING,
    this.tabIndex: 0,
    this.viewModel,
  });

  factory WalletListState.loading() {
    return WalletListState(status: WalletListStatus.LOADING);
  }

  factory WalletListState.dataLoaded(int tabIndex, ViewModel viewModel) {
    return WalletListState(status: WalletListStatus.DATA, tabIndex: tabIndex, viewModel: viewModel);
  }

  factory WalletListState.error() {
    return WalletListState(status: WalletListStatus.ERROR);
  }
}