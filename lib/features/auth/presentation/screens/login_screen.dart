import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../di/injection_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .surface,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .surface,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.posts,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const LoadingView();
                }

                if (state is AuthSuccess) {
                  return const SizedBox.shrink();
                }

                if (state is AuthFailure) {
                  return ErrorView(
                    message: state.message,
                    onRetry: () => _onLoginPressed(context),
                  );
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// Logo / Branding
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 56,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),

                      const SizedBox(height: 16),

                      /// Title
                      Text(
                        'Welcome back',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),

                      const SizedBox(height: 8),

                      /// Subtitle
                      Text(
                        'Sign in to continue',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey),
                      ),

                      const SizedBox(height: 32),

                      /// Auth Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              label: 'Email address',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: Validators.email,
                            ),

                            const SizedBox(height: 16),

                            AppTextField(
                              label: 'Password',
                              controller: _passwordController,
                              obscureText: true,
                              validator: Validators.password,
                            ),

                            const SizedBox(height: 24),

                            AppButton(
                              title: 'Sign in',
                              onPressed: () => _onLoginPressed(context),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Footer text
                      Text(
                        'By continuing, you agree to our Terms & Privacy Policy',
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

