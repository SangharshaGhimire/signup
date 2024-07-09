import 'package:flutter/material.dart';
import 'package:signup/ui/home.dart';
import 'package:signup/ui/role.dart';
import 'package:signup/ui/search.dart';
import 'package:signup/ui/setting.dart';

class Mainpages extends StatefulWidget {
  const Mainpages({super.key});

  @override
  State<Mainpages> createState() => _MainpagesState();
}

class _MainpagesState extends State<Mainpages> {
  int selectiveIndex = 0;
  List<Widget> pages = [
    Home(),
    Search(),
    roleUI(),
    Container(
      color: Colors.orange,
    ),
    Setting()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectiveIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectiveIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              selectiveIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("assets/images/home.jpg",
                    height: 30, width: 30),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/search1.jpg",
                  height: 30,
                  width: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/explore.jpg",
                  height: 30,
                  width: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/video.jpg",
                  height: 30,
                  width: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/setting.jpg",
                  height: 30,
                  width: 30,
                ),
                label: "")
          ]),
    );
  }
}
