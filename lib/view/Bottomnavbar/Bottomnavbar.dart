import 'package:flutter/material.dart';
import 'package:queryui/utils/colorconstants.dart';
import 'package:queryui/view/charactersScreen/charactersScreen.dart';
import 'package:queryui/view/episodeScreen/episodeScreen.dart';
import '../Location screen/locationScreen.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int selectedTab = 0;
  List screen = [
   const Charactersscreen(),
   const Locationscreen(),
   const Episodescreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedTab,
          onTap: (value) {
            selectedTab = value;
            setState(() {});
          },
          selectedItemColor: ColorConstants.PrimaryColor,
          unselectedItemColor: ColorConstants.darkgery,
          type: BottomNavigationBarType.fixed,
          items:const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_4_outlined), label: "Characters"),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              label: "Location",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.tv_sharp), label: "Episodes"),
          ]),
    );
  }
}
