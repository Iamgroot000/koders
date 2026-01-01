import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants/app_routes.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/posts/presentation/screens/post_detail_screen.dart';
import '../features/posts/presentation/screens/post_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean BLoC App',
      debugShowCheckedModeBanner: false,

      // App Theme
      theme: AppTheme.lightTheme,

      // Initial Route
      initialRoute: AppRoutes.login,

      // Named Routes
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.posts: (_) => const PostListScreen(),
        AppRoutes.postDetail: (_) => const PostDetailScreen(),

      },
    );
  }
}
