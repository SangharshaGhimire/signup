import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/ui/helper.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formGlobalKey,
            child: Consumer<RegisterProvider>(
              builder: (context, registerProvider, child) => Column(
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "You need to register your team to participate \n on this tournament.",
                            style: TextStyle(fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please register your team.",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: registerProvider.eventTitle,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter the event title";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Event Title",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      controller: registerProvider.teamName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter the team name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Team Name",
                          prefixIcon: Icon(Icons.person_3_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: registerProvider.contact,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter your contact number";
                        } else if (p0.length > 10) {
                          return "Invalid Number";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Contact",
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      controller: registerProvider.noOfPlayer,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter the number of player";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "No of players",
                          prefixIcon: Icon(Icons.person_4_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      controller: registerProvider.address,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Please enter your Address";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Address",
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              await registerProvider.setRegister();
                              if (registerProvider.RegisterStatus ==
                                  StatusUtil.success) {
                                Helper().showSnackBar(
                                    context, "successfully saved");
                              } else if (registerProvider.RegisterStatus ==
                                  StatusUtil.error) {
                                Helper().showSnackBar(
                                    context, registerProvider.errorMessage!);
                              }
                            }
                          },
                          child: Text("Register team")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
