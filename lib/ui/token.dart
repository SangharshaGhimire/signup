import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/provider/token_provider.dart';
import 'package:signup/ui/helper.dart';

class TokenUI extends StatefulWidget {
  const TokenUI({super.key});

  @override
  State<TokenUI> createState() => _TokenUIState();
}

class _TokenUIState extends State<TokenUI> {
  final formGlobalKey = GlobalKey<FormState>();
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formGlobalKey,
        child: Consumer<TokenProvider>(
          builder: (context, tokenProvider, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tokenProvider.email,
                  onChanged: (p0) {
                    tokenProvider.email.text = p0;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Email";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "| Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tokenProvider.password,
                  obscureText: isPressed == true ? false : true,
                  onChanged: (value) {
                    tokenProvider.password.text = value;
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
                  decoration: InputDecoration(
                      labelText: "| Password",
                      border: OutlineInputBorder(),
                      prefixIcon: IconButton(
                          onPressed: () {
                            if (isPressed == true) {
                              isPressed = false;
                            } else {
                              isPressed = true;
                            }
                            setState(() {
                              isPressed;
                            });
                          },
                          icon: Icon(isPressed
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: tokenProvider.username,
                  onChanged: (value) {
                    tokenProvider.username.text = value;
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Please enter your address";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "| Address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      await tokenProvider.setToken();

                      if (tokenProvider.statusUtil == StatusUtil.success) {
                        Helper().showSnackBar(context, "successfully saved");
                      } else if (tokenProvider.statusUtil == StatusUtil.error) {
                        Helper()
                            .showSnackBar(context, tokenProvider.errorMessage!);
                      }
                    }
                  },
                  child: Text("LogIn"))
            ],
          ),
        ),
      ),
    );
  }
}
