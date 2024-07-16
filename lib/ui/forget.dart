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
          children: [],
        ),
      ),
    );
  }
}
