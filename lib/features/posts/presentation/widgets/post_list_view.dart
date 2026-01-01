import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_routes.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import 'post_list_shimmer.dart';

class PostListView extends StatefulWidget {
  final List<PostEntity> posts;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? errorMessage;
  final ScrollController scrollController;

  const PostListView({
    Key? key,
    required this.posts,
    required this.isLoadingMore,
    required this.hasReachedMax,
    this.errorMessage,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostBloc>().add(LoadMorePostsRequested());
    }
  }

  bool get _isBottom {
    if (!widget.scrollController.hasClients) return false;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PostBloc>().add(FetchPostsRequested(page: 1));
      },
      child: ListView.builder(
        controller: widget.scrollController,
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: widget.hasReachedMax || widget.errorMessage != null
            ? widget.posts.length
            : widget.posts.length + 1,
        itemBuilder: (context, index) {
          if (index >= widget.posts.length) {
            if (widget.errorMessage != null) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }

          final post = widget.posts[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.postDetail,
                    arguments: post,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.08),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Category / Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'FEATURED',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// Title
                      Text(
                        post.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Body Preview
                      Text(
                        post.body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// Divider
                      Divider(
                        color: Colors.grey.withOpacity(0.15),
                      ),

                      const SizedBox(height: 10),

                      /// Meta Info Row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15),
                            child: Text(
                              post.title[0].toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color:
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Anonymous',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Icon(Icons.schedule, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '3 min read',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

