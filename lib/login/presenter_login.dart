import 'package:shiffr_wallet/app/model/bitfinex_repository.dart';
import 'package:shiffr_wallet/app/preferences.dart';
import 'package:shiffr_wallet/login/page_login.dart';

class LoginPresenter {
  final _preferences = Preferences();
  final _repository = BitfinexRepository();

  final LoginPage _view;

  LoginPresenter(this._view);

  void onLoginPressed(String key, String secret) async {
    print("login pressed: $key, $secret");

    try {
      final balances = await _repository.getBalances();

      _view.showBalancesPage(balances);

      _preferences.store(key, secret);
    } catch (exception) {
      print(exception.toString());
    }
  }

//
//  fetchPost() async {
//    final response = await get('https://jsonplaceholder.typicode.com/posts/1');
//    final responseJson = json.decode(response.body);
//
//    print("response: ${response.body}");
//    return Post.fromJson(responseJson);
//  }
//
//  void onData(Response event) {
//    print(event);
//  }
//
  proceedWithoutLogin() {}

  loadSavedCredentials() {
    loadData();
  }

  loadData() async {
    final tuple = await _preferences.get();
    final key = tuple.key;
    final secret = tuple.secret;

    print("load credentials: $key, $secret");
  }
}
