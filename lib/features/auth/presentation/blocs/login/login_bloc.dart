import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_with_email.dart';
import '../../../domain/usecases/login_with_google.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithEmail _loginWithEmail;
  final LoginWithGoogle _loginWithGoogle;

  LoginBloc(this._loginWithEmail, this._loginWithGoogle)
    : super(const LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
  }
  bool get isLoading => state == const LoginLoading();

  FutureOr<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final loginParams = LoginParams(
      email: event.email,
      password: event.password,
    );
    try {
      emit(const LoginLoading());
      await _loginWithEmail.call(loginParams);
      emit(const LoginSuccess());
    } on Exception catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(const LoginLoading());
      await _loginWithGoogle.call();
      emit(const LoginSuccess());
    } on Exception catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
