import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final post =
    ModalRoute.of(context)!.settings.arguments as PostEntity;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(''),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(
                post.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Meta Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.15),
                    child: Text(
                      post.title[0].toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anonymous',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'User ID • ${post.userId}',
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

            const SizedBox(height: 24),

            /// Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
            ),

            const SizedBox(height: 24),

            /// Article Body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                post.body,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.8,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 40),

            /// Footer Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Thanks for reading this article.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
