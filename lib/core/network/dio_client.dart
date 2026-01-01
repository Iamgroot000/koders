import 'package:dio/dio.dart';
import '../constants/api_endpoints.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        String? newBaseUrl, // Add newBaseUrl parameter
      }) async {
    final dioInstance = newBaseUrl != null
        ? Dio(BaseOptions(
            baseUrl: newBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            responseType: ResponseType.json,
          ))
        : _dio;

    if (newBaseUrl != null) {
      dioInstance.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }
    return await dioInstance.get(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        String? newBaseUrl, // New parameter for overriding base URL
      }) async {
    final dioInstance = newBaseUrl != null
        ? Dio(BaseOptions(
            baseUrl: newBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            responseType: ResponseType.json,
          ))
        : _dio;

    if (newBaseUrl != null) {
      dioInstance.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }

    return await dioInstance.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
