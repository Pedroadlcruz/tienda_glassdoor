import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository _authRepository;

  RegisterWithEmail(this._authRepository);

  Future<AppUser> call(String email, String password) {
    return _authRepository.signUpWithEmailAndPassword(email, password);
  }
}
