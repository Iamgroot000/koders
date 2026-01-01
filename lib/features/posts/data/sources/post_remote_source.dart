import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/post_model.dart';

abstract class PostRemoteSource {
  Future<List<PostModel>> fetchPosts({
    int page = 1,
    int limit = 10,
  });
}

class PostRemoteSourceImpl implements PostRemoteSource {
  final DioClient dioClient;

  PostRemoteSourceImpl(this.dioClient);

  @override
  Future<List<PostModel>> fetchPosts({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await dioClient.get(
      ApiEndpoints.posts,
      queryParameters: {
        '_page': page,
        '_limit': limit,
      },
    );

    final List data = response.data as List;
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
