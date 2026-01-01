import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(
        email: event.email,
        password: event.password,
      );

      emit(AuthSuccess(email: user.email));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
