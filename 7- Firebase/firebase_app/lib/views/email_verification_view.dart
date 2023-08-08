import 'dart:async';

import 'package:firebase_app/main.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({super.key});

  @override
  State<EmailVerificationView> createState() => _EmailVerificatioNViewntate();
}

class _EmailVerificatioNViewntate extends State<EmailVerificationView> {
  late final AuthService _authService;
  bool isVerified = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerification();
    });
  }

  Future<void> checkEmailVerification() async {
    await _authService.reload();
    setState(() {
      isVerified = _authService.currentUser!.emailVerified;
    });

    if (isVerified) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email Successfully Verified")),
      );
      timer?.cancel();

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email on  ${_authService.currentUser!.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Resend'),
                  onPressed: () {
                    try {
                      _authService.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
