import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/app_user.dart';

abstract class AuthRepository {
  AppUser getCurrentUser();

  Future<AppUser> signInWithEmailAndPassword(String email, String password);

  Future<AppUser> signUpWithEmailAndPassword(String email, String password);

  Future<AppUser> signInWithGoogle();

  Future<void> signOut();

  Stream<AppUser> get authStateChanges;

  AppUser convertFirebaseUser(User firebaseUser);
}
