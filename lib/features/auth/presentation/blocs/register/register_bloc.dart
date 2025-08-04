import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_with_google.dart';
import '../../../domain/usecases/register_with_email.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterWithEmail _registerWithEmail;
  final LoginWithGoogle _registerWithGoogle;
  RegisterBloc(this._registerWithEmail, this._registerWithGoogle)
    : super(const RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterWithGooglePressed>(_onRegisterWithGooglePressed);
  }
  bool get isLoading => state == const RegisterLoading();

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    final registerParams = RegisterParams(
      email: event.email,
      password: event.password,
    );
    try {
      emit(const RegisterLoading());
      await _registerWithEmail.call(registerParams);
      emit(const RegisterSuccess());
    } on Exception catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> _onRegisterWithGooglePressed(
    RegisterWithGooglePressed event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(const RegisterLoading());
      await _registerWithGoogle.call();
      emit(const RegisterSuccess());
    } on Exception catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
