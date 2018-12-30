
import 'package:http/http.dart';
import 'package:shiffr_wallet/common/api/api_error.dart';

/// Retrieves response body if response code successful, otherwise throws ApiError
String handleResponse(Response response) {
  final statusCode = response.statusCode;

  if (_isSuccess(statusCode)) {
//      print("success loading orders: ${response.body}");
    return response.body;
  } else {
//      print("error loading orders: $statusCode  ${response.body}");
    throw ApiError(statusCode, response.body);
  }
}

bool _isSuccess(int statusCode) => statusCode >= 200 && statusCode < 300;