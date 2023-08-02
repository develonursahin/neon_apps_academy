import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SigninViewModel with ChangeNotifier {
  late final AuthService _authService; 

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void init() {
    _authService = AuthService();
  }

  Future<User?> signIn() async {
    try {
      final result = await _authService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      return result;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }
    }
    return null;
  }
}
