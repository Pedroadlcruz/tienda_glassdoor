import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository _authRepository;

  LoginWithEmail(this._authRepository);

  Future<AppUser> call(String email, String password) {
    return _authRepository.signInWithEmailAndPassword(email, password);
  }
}
