import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/provider/login_provider.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<LoginProvider>(
        builder: (context, loginprovider, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                onChanged: (value) {
                  loginprovider.passwordTextField.text = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return "Password must contain at least one digit";
                  }
                  if (!RegExp(r'\W').hasMatch(value)) {
                    return "Password must contain at least one special character";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: loginprovider.passwordTextField,
                decoration: InputDecoration(
                    labelText: "New Password", border: OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                onChanged: (value) {
                  loginprovider.passwordTextField.text = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (!RegExp(r'\d').hasMatch(value)) {
                    return "Password must contain at least one digit";
                  }
                  if (!RegExp(r'\W').hasMatch(value)) {
                    return "Password must contain at least one special character";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: loginprovider.passwordTextField,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
