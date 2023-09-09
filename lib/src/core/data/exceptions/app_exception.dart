class AppException implements Exception {
  final String message;
  final String? detailedMessage;
  AppException(this.message, {this.detailedMessage});
}
