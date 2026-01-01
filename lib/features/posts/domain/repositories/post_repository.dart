import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> fetchPosts({
    int page = 1,
    int limit = 10,
  });
}
