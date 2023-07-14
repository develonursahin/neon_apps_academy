import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldScreenState createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]+$');
    return emailRegex.hasMatch(email);
  }

  void validateAndSaveEmail(String email) {
    setState(() {
      if (validateEmail(email)) {
        errorMessage = '';
      } else {
        errorMessage = 'Enter a valid email address.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextFields'),
      ),
      body: Container(
        margin: const EdgeInsets.all(100),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter Fullname',
                labelStyle: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              minLines: 1,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter E-mail',
                labelStyle: const TextStyle(
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
                errorText: errorMessage.isNotEmpty ? errorMessage : null,
              ),
              onChanged: (value) {
                validateAndSaveEmail(value);
              },
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                labelStyle: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
