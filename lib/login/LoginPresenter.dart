import 'package:shiffr_wallet/app/Preferences.dart';

class LoginPresenter {
  final _preferences = Preferences();

  LoginPresenter();

  void onLoginPressed(String key, String secret) {
    print("login pressed: $key, $secret");
    _preferences.store(key, secret);
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
  proceedWithoutLogin() {

  }

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
