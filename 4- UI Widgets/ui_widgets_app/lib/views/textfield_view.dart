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
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                labelText: 'Enter Fullname',
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              minLines: 1,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
            ),
            TextField(
              style: const TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Enter E-mail',
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
              style: TextStyle(
                color: Colors.green,
                decoration: TextDecoration.underline,
              ),
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
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
