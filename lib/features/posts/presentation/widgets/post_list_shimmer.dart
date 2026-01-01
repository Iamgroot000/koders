import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostListShimmer extends StatelessWidget {
  const PostListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).colorScheme.primary;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Shimmer.fromColors(
            baseColor: base.withOpacity(0.12),
            highlightColor: base.withOpacity(0.04),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.95),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              base.withOpacity(0.15),
                              base.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [
                                base.withOpacity(0.15),
                                base.withOpacity(0.05),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Title
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          base.withOpacity(0.18),
                          base.withOpacity(0.06),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Body
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          base.withOpacity(0.14),
                          base.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 14,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          base.withOpacity(0.14),
                          base.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 12,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              base.withOpacity(0.14),
                              base.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              base.withOpacity(0.14),
                              base.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
