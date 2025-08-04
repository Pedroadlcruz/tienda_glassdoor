import '../../data/models/app_user.dart';
import '../repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository _authRepository;

  AuthUseCases(this._authRepository);

  AppUser getCurrentUser() {
    return _authRepository.getCurrentUser();
  }

  Future<void> signOut() {
    return _authRepository.signOut();
  }

  Stream<AppUser?> get authStateChanges {
    return _authRepository.authStateChanges;
  }
}
