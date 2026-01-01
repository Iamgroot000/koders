import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiException(message: 'Request timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Response timeout');
      case DioExceptionType.badResponse:
        return ApiException(
          message: error.response?.data['error'] ??
              'Something went wrong',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled');
      default:
        return ApiException(message: 'Unexpected error occurred');
    }
  }

  @override
  String toString() => message;
}
