import '../../domain/entities/post_entity.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {
  final List<PostEntity> posts;

  PostLoading({this.posts = const []});
}

class PostLoaded extends PostState {
  final List<PostEntity> posts;
  final bool hasReachedMax;
  final int currentPage;

  PostLoaded({required this.posts, this.hasReachedMax = false, this.currentPage = 1});

  PostLoaded copyWith({
    List<PostEntity>? posts,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class PostError extends PostState {
  final String message;
  final List<PostEntity> posts;

  PostError({required this.message, this.posts = const []});
}
