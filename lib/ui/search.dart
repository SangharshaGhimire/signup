import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';
import 'package:signup/provider/signup_Provider.dart';
import 'package:signup/ui/Signuui.dart';
import 'package:signup/ui/helper.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    getValueFromApi();

    super.initState();
  }

  getValueFromApi() {
    var provider = Provider.of<SignupProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () async {
      await provider.getSignup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<SignupProvider>(
          builder: (context, signupprovider, child) => ListView.builder(
            itemCount: signupprovider.userList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Text(
                              "Name:${signupprovider.userList[index].name ?? "Name"}"),
                          Text(
                              "Email:${signupprovider.userList[index].email ?? "Email"}"),
                          Text(
                              "Password:${signupprovider.userList[index].password ?? "Password"}"),
                          Text(
                              "Contact:${signupprovider.userList[index].contactNumber ?? "Phone Number"}"),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showEditAlert(
                              context, signupprovider.userList[index]);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          showDeleteAlert(context, signupprovider,
                              signupprovider.userList[index].id.toString());
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  showDeleteAlert(
      BuildContext content, SignupProvider signupprovider, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Do you want to Delete"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await signupprovider.deleteUser(id).then((value) async {
                      if (signupprovider.DeleteStatus == StatusUtil.success) {
                        Navigator.pop(context);
                        await signupprovider.getSignup();
                        Helper().showSnackBar(context, "Successfully Delete");
                      } else if (signupprovider.DeleteStatus ==
                          StatusUtil.error) {
                        Helper().showSnackBar(context, "Error");
                      }
                    });
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  showEditAlert(BuildContext content, Signup signup) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit"),
            content: Text("Do You want to edit"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUPUI(
                                  signup: signup,
                                )));
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("NO"))
            ],
          );
        });
  }
}
