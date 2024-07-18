import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'package:signup/provider/login_provider.dart';
import 'package:signup/ui/helper.dart';
import 'package:signup/ui/mobilenumber.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key, this.verificationId});
  String? verificationId;
  String? smsCode = "";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileNumber()));
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Text(
                  "OTP VERIFICATION",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Enter code here",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color.fromARGB(255, 43, 16, 107),
              borderRadius: BorderRadius.circular(20),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                widget.smsCode = widget.smsCode! + code;
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    });
              }, // end onSubmit
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationId!,
                            smsCode: widget.smsCode!);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Helper().showSnackBar(context, "success");
                  } catch (e) {
                    Helper().showSnackBar(context, "invalid code");
                  }
                },
                child: Text("Proceed"))
          ],
        ),
      ),
    );
  }
}
