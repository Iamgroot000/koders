import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';
import '../widgets/post_list_shimmer.dart';
import '../widgets/post_list_view.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}



class _PostListScreenState extends State<PostListScreen> {
  late final ScrollController _scrollController;
  bool _showShimmer = true;
  Timer? _shimmerTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startShimmerTimer();
  }

  void _startShimmerTimer() {
    _shimmerTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showShimmer = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _shimmerTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PostBloc>()..add(FetchPostsRequested(page: 1)),
      child: Scaffold(
        // appBar: AppBar(title: const Text('Posts')),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            // Safely extract posts from various states
            final List<PostEntity> posts = switch (state) {
              PostLoaded(:final posts) => posts,
              PostLoading(:final posts) => posts,
              PostError(:final posts) => posts,
              _ => [],
            };

            // Initial loading with shimmer
            if (_showShimmer && posts.isEmpty) {
              return const PostListShimmer();
            }
            if (state is PostLoading && posts.isEmpty && !_showShimmer) {
              return const Center(child: CircularProgressIndicator());
            }

            // Initial error with no posts
            if (state is PostError && posts.isEmpty) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<PostBloc>().add(FetchPostsRequested(page: 1));
                },
              );
            }

            // Empty state (no posts after loading)
            if (posts.isEmpty) {
              return const EmptyView(message: 'No posts available');
            }

            // Display the list with refresh and pagination capabilities
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(FetchPostsRequested(page: 1));
              },
              child: PostListView(
                posts: posts,
                isLoadingMore: state is PostLoading,
                hasReachedMax: state is PostLoaded ? state.hasReachedMax : false,
                errorMessage: state is PostError ? state.message : null,
                scrollController: _scrollController,
              ),
            );
          },
        ),
      ),
    );
  }
}
