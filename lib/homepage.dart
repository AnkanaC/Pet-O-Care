import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pet_o_care/pages/chatbot.dart';
import 'package:pet_o_care/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List Pages = [
    ProfilePage(),
    ChatBotPage(),
  ];

  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(198, 247, 244, 100),
      extendBody: true,

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.favorite, size: 30),
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