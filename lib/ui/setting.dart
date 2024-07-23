import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/provider/login_provider.dart';
import 'package:signup/ui/loginui.dart';

class Setting extends StatefulWidget {
  Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  File file = File("");
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                var remember = prefs.getBool('isRemember');
                if (remember == true) {
                  await prefs.remove('isLogin');
                } else {
                  await prefs.remove('email');
                  await prefs.remove('password');
                  await prefs.remove('isLogin');
                  await prefs.remove('isRemember');
                  context.read<LoginProvider>().clearData();
                }

                // context.read<LoginProvider>().clearData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginUI()));
              },
              child: Text("Log Out")),
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: file.path.isEmpty
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/plant.jpg"),
                  ) //
                : CircleAvatar(
                    radius: 40,
                    backgroundImage: FileImage(file),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140),
            child: ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: loader == true
                    ? CircularProgressIndicator()
                    : Text("Upload")),
          )
        ],
      ),
    );
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    // final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    file = File(image!.path);
    setState(() {
      loader = true;
      file;
    });
    try {
      String fileName = file.path.split('/').last;

      var storageReference = FirebaseStorage.instance.ref();
      var uploadReference = storageReference.child(fileName);
      await uploadReference.putFile(file);
      String? downlaodUrl = await uploadReference.getDownloadURL();
      print("downloadUrl$downlaodUrl");

      var json = {
        "image_url": downlaodUrl,
        "name": "Sangharsha",
      };
      await FirebaseFirestore.instance.collection("user").add(json);

      setState(() {
        loader = false;
      });
    } catch (e) {
      setState(() {
        loader = false;
      });
    }
  }
}
