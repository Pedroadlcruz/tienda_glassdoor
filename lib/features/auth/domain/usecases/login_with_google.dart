import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogle {
  final AuthRepository authRepository;

  LoginWithGoogle({required this.authRepository});

  Future<AppUser> call() {
    return authRepository.signInWithGoogle();
  }
}
