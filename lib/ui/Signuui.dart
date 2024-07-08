import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';
import 'package:signup/provider/signup_Provider.dart';
import 'package:signup/ui/helper.dart';
import 'package:signup/ui/loginui.dart';

class SignUPUI extends StatefulWidget {
  Signup? signup;
  SignUPUI({super.key, this.signup});

  @override
  State<SignUPUI> createState() => _SignUPUIState();
}

class _SignUPUIState extends State<SignUPUI> {
  final formGlobalKey = GlobalKey<FormState>();
  bool isPressed = false;
  @override
  void initState() {
    var provider = Provider.of<SignupProvider>(context, listen: false);
    if (widget.signup != null) {
      provider.setId(widget.signup!.id);
      provider.name.text = widget.signup!.name!;
      provider.password.text = widget.signup!.password!;
      provider.email.text = widget.signup!.email!;
      provider.contactNumber.text = widget.signup!.contactNumber!;
      provider.id.text = widget.signup!.id!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formGlobalKey,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue)),
              Padding(
                padding: const EdgeInsets.only(left: 150, top: 40),
                child: Container(
                  child: CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 60,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: SafeArea(
                  child: Consumer<SignupProvider>(
                    builder: (context, signupprovider, child) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: signupprovider.name,
                            onChanged: (value) {
                              signupprovider.name.text = value;
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please enter your first name";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                labelText: "| Name",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: signupprovider.email,
                            onChanged: (p0) {
                              signupprovider.email.text = p0;
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
                            controller: signupprovider.password,
                            obscureText: isPressed == true ? false : true,
                            onChanged: (value) {
                              signupprovider.password.text = value;
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
                            controller: signupprovider.contactNumber,
                            onChanged: (value) {
                              signupprovider.contactNumber.text = value;
                            },
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Please enter your phonenumber";
                              } else if (p0.length > 10) {
                                return "Invalid number";
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                                labelText: "| PhoneNumber",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone)),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (formGlobalKey.currentState!.validate()) {
                                  await signupprovider.setSignup();

                                  if (signupprovider.SignupStatus ==
                                      StatusUtil.success) {
                                    Helper().showSnackBar(
                                        context, "successfully saved");
                                  } else if (signupprovider.SignupStatus ==
                                      StatusUtil.error) {
                                    Helper().showSnackBar(
                                        context, signupprovider.errorMessage!);
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginUI()));
                                }
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.green),
                              )),
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
                                  fontSize: 30, color: Colors.deepOrange),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("if you haven't any account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginUI()));
                                  },
                                  child: Text("sign In"))
                            ],
                          ),
                        )
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
