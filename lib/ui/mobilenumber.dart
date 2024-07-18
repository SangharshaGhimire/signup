import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup/ui/forget.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Forget password",
              style: TextStyle(color: Colors.black, fontSize: 30)),
          SizedBox(height: 10),
          Text("Recover your password",
              style: TextStyle(color: Colors.grey, fontSize: 25)),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration: InputDecoration(
                labelText: "Phone number",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '+977$phoneNumber',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword(
                                  verificationId: verificationId,
                                )));
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text("Recover"))
        ],
      ),
    );
  }
}
