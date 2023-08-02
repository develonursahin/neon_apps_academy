import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupViewModel with ChangeNotifier {
  late final AuthService _authService;
  late final UserService _userService;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool isTaken = false;

  Future<void> createUser() async {
    UserModel userModel = UserModel(
      id: _authService.currentUser!.uid,
      name: nameController.text,
      userName: usernameController.text,
      surname: surnameController.text,
      email: emailController.text,
    );
    await _userService.create(userModel);
  }

  void init() {
    _userService = UserService();
    _authService = AuthService();
  }

  Future<User?> signUp() async {
    try {
      await isUsernameTaken(usernameController.text);
      if (isTaken) {
        if (kDebugMode) {
          print("Username is already taken: ${usernameController.text}");
        }
        return null;
      }
      final result = await _authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      return result;
    } catch (e) {
      if (kDebugMode) {
        print("Error signing up: $e");
      }
    }
    return null;
  }

  Future<void> isUsernameTaken(String userName) async {
    bool result = await _userService.checkUsernameExists(userName);
    isTaken = result;
  }
}
