import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());

      await Future.delayed(Duration(seconds: 1)); // simulate delay

      if (event.password.length < 8) {
        emit(AuthFailure("Password must be at least 8 characters long"));
      } else {
        emit(AuthSuccess());
      }
    });
  }
}
