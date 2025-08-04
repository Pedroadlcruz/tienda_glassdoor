import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/app_user.dart';
import '../../../domain/usecases/auth_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases _authUseCases;
  StreamSubscription<AppUser?>? _authStateSubscription;

  AuthBloc(this._authUseCases) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignOut>(_onSignOut);
    on<AuthStateChanged>(_onAuthStateChanged);

    _authStateSubscription = _authUseCases.authStateChanges.listen((user) {
      add(AuthStateChanged(user ?? AppUser.empty));
    });
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final user = _authUseCases.getCurrentUser();
    emit(AuthAuthenticated(user));
  }

  Future<void> _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _authUseCases.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    if (event.user != AppUser.empty) {
      emit(AuthAuthenticated(event.user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
