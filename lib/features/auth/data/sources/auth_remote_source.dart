import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_exception.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final DioClient dioClient;

  AuthRemoteSourceImpl(this.dioClient);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.get(
        ApiEndpoints.login,
      );

      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
