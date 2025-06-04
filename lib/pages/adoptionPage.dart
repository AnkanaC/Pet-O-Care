import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class AdoptionPage extends StatefulWidget {
  const AdoptionPage({super.key});

  @override
  State<AdoptionPage> createState() => _AdoptionPageState();
}

class _AdoptionPageState extends State<AdoptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Adoption Page', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FabCircularMenu(
        alignment: const Alignment(0.9, 0.6), // Custom x, y

        ringColor: Colors.purple.withOpacity(0.6),
        ringDiameter: 250.0,
        ringWidth: 60.0,
        fabSize: 64.0,
        fabElevation: 8.0,
        fabIconBorder: const CircleBorder(),
        fabColor: Colors.deepPurple,
        fabOpenIcon: const Icon(Icons.favorite, color: Colors.white),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white),
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.pets, color: Colors.white),
            onPressed: () => debugPrint("Pet Icon Clicked"),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => debugPrint("Search Icon Clicked"),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => debugPrint("Add Icon Clicked"),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () => debugPrint("Favorite Icon Clicked"),
          ),
        ],
      ),
    );
  }
}
