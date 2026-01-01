import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../core/network/dio_client.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/data/sources/auth_remote_source.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

import '../features/posts/data/repositories/post_repository_impl.dart';
import '../features/posts/data/sources/post_remote_source.dart';
import '../features/posts/domain/repositories/post_repository.dart';
import '../features/posts/domain/usecases/fetch_posts_usecase.dart';
import '../features/posts/presentation/bloc/post_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));


  // Bloc
  sl.registerFactory(
        () => AuthBloc(
      loginUseCase: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  // Remote Source
  sl.registerLazySingleton<AuthRemoteSource>(
        () => AuthRemoteSourceImpl(sl()),
  );



  // Bloc
  sl.registerFactory(
        () => PostBloc(
      fetchPostsUseCase: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton<FetchPostsUseCase>(
        () => FetchPostsUseCase(sl()),
  );

  // Repository
  sl.registerLazySingleton<PostRepository>(
        () => PostRepositoryImpl(sl()),
  );

  // Remote Source
  sl.registerLazySingleton<PostRemoteSource>(
        () => PostRemoteSourceImpl(sl()),
  );
}
