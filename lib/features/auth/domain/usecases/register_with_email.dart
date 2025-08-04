import 'package:equatable/equatable.dart';

import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository _authRepository;

  RegisterWithEmail(this._authRepository);

  Future<AppUser> call(RegisterParams params) {
    return _authRepository.signUpWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password}) : super();

  @override
  List<Object?> get props => [email, password];
}
