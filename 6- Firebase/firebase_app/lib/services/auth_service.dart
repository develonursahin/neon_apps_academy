import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  late final FirebaseAuth _auth;
  AuthService() {
    _auth = FirebaseAuth.instance;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user!;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }
      rethrow;
    }
  }

  User? get currentUser => _auth.currentUser;
  bool get isVerified => currentUser!.emailVerified;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing up: $e");
      }
      return null;
    }
  }

  void sendEmailVerification() {
    currentUser!.sendEmailVerification();
  }

  Future<void> reload() async {
    await currentUser!.reload();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
