import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repository.dart';
import '../models/app_user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  AppUser getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    return firebaseUser != null
        ? convertFirebaseUser(firebaseUser)
        : AppUser.empty;
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Ha ocurrido un error al iniciar sesión');
      }

      return convertFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } on Exception catch (_) {
      throw Exception(
        'Ha ocurrido un error inesperado durante el inicio de sesión',
      );
    }
  }

  @override
  Future<AppUser> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw Exception('Ha ocurrido un error al registrarse');
      }

      return convertFirebaseUser(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } on Exception catch (_) {
      throw Exception(
        'Ha ocurrido un error inesperado durante el inicio de sesión',
      );
    }
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      // Sign out first to ensure clean state
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Inicio de sesión cancelado por el usuario');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (googleAuth.accessToken == null) {
        throw Exception(
          'Ha ocurrido un error inesperado durante el inicio de sesión con Google',
        );
      }

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception(
          'Ha ocurrido un error inesperado durante el inicio de sesión con Google',
        );
      }

      final appUser = convertFirebaseUser(firebaseUser);

      return appUser;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception(
        'Ha ocurrido un error inesperado durante el inicio de sesión con Google',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  @override
  Stream<AppUser> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null
          ? convertFirebaseUser(firebaseUser)
          : AppUser.empty;
    });
  }

  @override
  AppUser convertFirebaseUser(User firebaseUser) {
    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
    );
  }

  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
      case 'invalid-credential':
        return Exception('Correo o contraseña incorrectos');
      case 'email-already-in-use':
        return Exception('El correo electrónico ya está en uso');
      case 'weak-password':
        return Exception('La contraseña es demasiado débil');
      case 'account-exists-with-different-credential':
        return Exception('Ya existe una cuenta con esas credenciales.');
      case 'operation-not-allowed':
        return Exception(
          'Ha ocurrido un error desconocido. Por favor, inténtalo de nuevo más tarde.',
        );
      default:
        return Exception('Ha ocurrido un error inesperado');
    }
  }
}
