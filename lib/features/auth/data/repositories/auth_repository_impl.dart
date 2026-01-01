import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource remoteSource;

  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final responseModel = await remoteSource.login(
      email: email,
      password: password,
    );

    return responseModel.toEntity();
  }
}
