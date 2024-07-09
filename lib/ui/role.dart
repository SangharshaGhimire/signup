import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:signup/provider/role_provider.dart';

class roleUI extends StatefulWidget {
  const roleUI({super.key});

  @override
  State<roleUI> createState() => _roleUIState();
}

class _roleUIState extends State<roleUI> {
  final formGlobalKey = GlobalKey<FormState>();
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formGlobalKey,
        child: Consumer<RoleProvider>(
          builder: (context, roleprovider, child) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: roleprovider.username,
                  onChanged: (value) {
                    roleprovider.username.text = value;
                  },
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      labelText: "| UserName",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: roleprovider.email,
                  onChanged: (p0) {
                    roleprovider.email.text = p0;
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
                  controller: roleprovider.password,
                  obscureText: isPressed == true ? false : true,
                  onChanged: (value) {
                    roleprovider.password.text = value;
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
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: Text("LogIn"))
            ],
          ),
        ),
      ),
    );
  }
}
