import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../sources/post_remote_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteSource remoteSource;

  PostRepositoryImpl(this.remoteSource);

  @override
  Future<List<PostEntity>> fetchPosts({
    int page = 1,
    int limit = 10,
  }) async {
    final models = await remoteSource.fetchPosts(page: page, limit: limit);
    return models.map((e) => e.toEntity()).toList();
  }
}
