import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/app.dart';
import 'di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await di.init();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

/// Global BLoC Observer (for logging & debugging)
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('BLoC Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('BLoC Transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('BLoC Error: $error');
    super.onError(bloc, error, stackTrace);
  }
}
