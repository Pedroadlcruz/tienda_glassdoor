import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout({required this.authRepository});

  Future<void> call() {
    return authRepository.signOut();
  }
}
