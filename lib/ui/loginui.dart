import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/provider/login_provider.dart';
import 'package:signup/ui/Signuui.dart';
import 'package:signup/ui/helper.dart';
import 'package:signup/ui/page.dart';


class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final formGlobalKey = GlobalKey<FormState>();
  bool isPressed = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<LoginProvider>(context, listen: false);
      provider.ReadRememberMe();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formGlobalKey,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Consumer<LoginProvider>(
                  builder: (context, loginprovider, child) =>
                      SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome \nback...",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                "assets/images/plant.jpg",
                                height: 80,
                                width: 80,
                              )),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            onChanged: (p0) {
                              loginprovider.emailTextField.text = p0;
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
                            controller: loginprovider.emailTextField,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                labelText: "| Email",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.mail)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: isPressed == true ? false : true,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: loginprovider.passwordTextField,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              value: loginprovider.isChecked,
                              onChanged: (value) {
                                loginprovider.CheckStatus(value);
                                loginprovider.RememberMe(value!);
                              },
                            ),
                            Text(
                              "Remember Me",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forget password",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUPUI()));
                                },
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.green),
                                )),
                            SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      await loginprovider.getSignup();
                                      if (loginprovider.LoginStatus ==
                                          StatusUtil.success) {
                                        if (loginprovider.isUserCheckStatus) {
                                          Helper().showSnackBar(
                                              context, "login Successful");
                                          loginprovider
                                              .saveValueToSharedPreference();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Mainpages()));
                                        } else {
                                          Helper().showSnackBar(
                                              context, "invalid Data");
                                        }
                                      }
                                    } else if (loginprovider.LoginStatus ==
                                        StatusUtil.error) {
                                      Helper().showSnackBar(
                                          context, "loginFailed");
                                    }
                                  },
                                  child: Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "-",
                              style: TextStyle(
                                  fontSize: 80, color: Colors.deepOrange),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.deepOrange),
                            ),
                            Text("-",
                                style: TextStyle(
                                  fontSize: 80,
                                  color: Colors.deepOrange,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                      "assets/images/facebook.jpg",
                                      height: 40,
                                      width: 40)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/images/google.jpg",
                                    height: 40,
                                    width: 40,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    "assets/images/instagram.jpg",
                                    height: 40,
                                    width: 30,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
