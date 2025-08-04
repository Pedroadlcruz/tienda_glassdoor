import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmail {
  final AuthRepository authRepository;

  RegisterWithEmail({required this.authRepository});

  Future<AppUser> call(String email, String password) {
    return authRepository.signUpWithEmailAndPassword(email, password);
  }
}
