import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogle {
  final AuthRepository _authRepository;

  LoginWithGoogle(this._authRepository);

  Future<AppUser> call() {
    return _authRepository.signInWithGoogle();
  }
}
