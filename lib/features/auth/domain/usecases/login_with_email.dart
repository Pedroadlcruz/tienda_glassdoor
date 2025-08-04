import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository authRepository;

  LoginWithEmail({required this.authRepository});

  Future<AppUser> call(String email, String password) {
    return authRepository.signInWithEmailAndPassword(email, password);
  }
}
