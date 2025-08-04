import 'package:equatable/equatable.dart';

import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository _authRepository;

  LoginWithEmail(this._authRepository);

  Future<AppUser> call(LoginParams params) {
    return _authRepository.signInWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password}) : super();

  @override
  List<Object?> get props => [email, password];
}
