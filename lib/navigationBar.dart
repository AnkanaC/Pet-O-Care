import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_o_care/homepage.dart';
import 'package:pet_o_care/pages/adoptionPage.dart';
import 'package:pet_o_care/pages/chatbot.dart';
import 'package:pet_o_care/pages/nearbyOptions.dart';
import 'package:pet_o_care/pages/profile.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {

   List Pages = [
    nearbyOptions(),
    ChatBotPage(),
    HomePage(),
    PetProfilePage(),
    AdoptionPage(),
  ];

  int _selectedIndex = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(198, 247, 244, 100),
      extendBody: true,

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        items: [
          Icon(Icons.search, size: 30),
          Icon(Icons.help_center, size: 30),
          Icon(Icons.home, size: 30),
          Icon(Icons.local_activity, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Pages[_selectedIndex], 
    );
  }
}
