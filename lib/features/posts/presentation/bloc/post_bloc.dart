import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_event.dart';
import 'post_state.dart';
import '../../domain/usecases/fetch_posts_usecase.dart';
import '../../domain/entities/post_entity.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchPostsUseCase fetchPostsUseCase;
  static const int _postLimit = 10;

  PostBloc({required this.fetchPostsUseCase}) : super(PostInitial()) {
    on<FetchPostsRequested>(_onFetchPosts);
    on<LoadMorePostsRequested>(_onLoadMorePosts);
  }

  Future<void> _onFetchPosts(
      FetchPostsRequested event,
      Emitter<PostState> emit,
      ) async {
      if (event.page == 1) {
        emit(PostLoading());
      } else if (state is PostLoaded) {
        emit(PostLoading(posts: (state as PostLoaded).posts));
      }

    try {
      final posts = await fetchPostsUseCase(
        page: event.page,
        limit: _postLimit,
      );

      if (event.page == 1) {
        emit(PostLoaded(
          posts: posts,
          currentPage: event.page,
          hasReachedMax: posts.length < _postLimit,
        ));
      } else if (state is PostLoaded) {
        final currentPosts = (state as PostLoaded).posts;
        emit((state as PostLoaded).copyWith(
          posts: currentPosts + posts,
          currentPage: event.page,
          hasReachedMax: posts.length < _postLimit,
        ));
      }
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> _onLoadMorePosts(
      LoadMorePostsRequested event,
      Emitter<PostState> emit,
      ) async {
    if (state is PostLoaded && !(state as PostLoaded).hasReachedMax) {
      final currentPage = (state as PostLoaded).currentPage;
      await _onFetchPosts(FetchPostsRequested(page: currentPage + 1), emit);
    }
  }
}
