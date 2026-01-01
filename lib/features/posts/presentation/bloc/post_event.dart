abstract class PostEvent {}

class FetchPostsRequested extends PostEvent {
  final int page;

  FetchPostsRequested({this.page = 1});
}

class LoadMorePostsRequested extends PostEvent {}
