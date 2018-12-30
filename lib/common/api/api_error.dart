

class ApiError implements Exception {
  final int statusCode;
  final String errorMessage;

  ApiError(this.statusCode, this.errorMessage);
}