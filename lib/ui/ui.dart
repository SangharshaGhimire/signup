import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/ui/helper.dart';

class dataUI extends StatefulWidget {
  const dataUI({super.key});

  @override
  State<dataUI> createState() => _UIState();
}

class _UIState extends State<dataUI> {
  void initState() {
    getValueFromApi();

    super.initState();
  }

  getValueFromApi() {
    var provider = Provider.of<RegisterProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () async {
      await provider.getRegister();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(
          builder: (context, registerprovider, child) => SizedBox(
                height: 800,
                width: 500,
                child: ListView.builder(
                    itemCount: registerprovider.userList1.length,
                    itemBuilder: (context, index) => Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(registerprovider
                                          .userList1[index].eventTitle ??
                                      " Event Title"),
                                  Text(registerprovider
                                          .userList1[index].teamName ??
                                      "Team Name"),
                                  Text(registerprovider
                                          .userList1[index].contact ??
                                      "Contact"),
                                  Text(registerprovider
                                          .userList1[index].noOfPlayers
                                          .toString() ??
                                      "No of player"),
                                  Text(registerprovider
                                          .userList1[index].address ??
                                      "Address"),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    showDeleteAlert(
                                        context,
                                        registerprovider,
                                        registerprovider.userList1[index].id
                                            .toString());
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        )),
              )),
    );
  }

  showDeleteAlert(
      BuildContext content, RegisterProvider registerprovider, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Do you want to Delete"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await registerprovider
                        .deleteRegister(id)
                        .then((value) async {
                      if (registerprovider.DeleteStatus == StatusUtil.success) {
                        Navigator.pop(context);
                        await registerprovider.getRegister();
                        print("success");
                      } else if (registerprovider.DeleteStatus ==
                          StatusUtil.error) {
                        print("error");
                        // Helper().showSnackBar(context, "Error");
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
}
