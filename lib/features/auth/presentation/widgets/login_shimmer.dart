import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoginShimmer extends StatelessWidget {
  const LoginShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: 28.0,
              color: Colors.white,
            ),
            const SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              height: 56.0,
              color: Colors.white,
            ),
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              height: 56.0,
              color: Colors.white,
            ),
            const SizedBox(height: 32.0),
            Container(
              width: double.infinity,
              height: 48.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

