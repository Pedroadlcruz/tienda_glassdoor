import 'package:equatable/equatable.dart';

import '../../../data/models/app_user.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class CheckAuthStatus extends AuthEvent {}

final class SignOut extends AuthEvent {}

final class AuthStateChanged extends AuthEvent {
  final AppUser user;

  const AuthStateChanged(this.user);

  @override
  List<Object?> get props => [user];
}
