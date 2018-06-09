import 'package:flutter/src/widgets/editable_text.dart';

class LoginPresenter {
//  final _preferences = Preferences();
//  final TextEditingController _keyController;
//  final TextEditingController _secretController;

  LoginPresenter();

  void onLoginPressed(String key, String secret) {
//    final key = _keyController.text;
//    final secret = _secretController.text;

    print("login pressed: $key, $secret");
//    _preferences.store(key, secret);
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
//    final tuple = await _preferences.get();
//    final key = tuple.key;
//    final secret = tuple.secret;
//
//    _keyController.text = key;
//    _secretController.text = secret;
  }

}
