import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository repository;

  FetchPostsUseCase(this.repository);

  Future<List<PostEntity>> call({
    int page = 1,
    int limit = 10,
  }) {
    return repository.fetchPosts(page: page, limit: limit);
  }
}
