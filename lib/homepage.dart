import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hi User",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const IconButton(
                      icon: Icon(Icons.notifications, size: 30),
                      onPressed: null,
                      color: Colors.black,
                      hoverColor: Colors.purple,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 199, 68, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  Positioned(
                    top: 30,
                    left: 20,
                    child: Image.asset(
                      'assets/orangePaw.png',
                      width: 30,
                      height: 30,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    left: 40,
                    child: Image.asset(
                      'assets/orangePaw.png',
                      width: 50,
                      height: 35,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),

                  Positioned(
                    top: 90,
                    left: 40,
                    child: SizedBox(
                      width: 180, 
                      child: Text(
                        "The Street Animals Need your help Today!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    left: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Donate Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: -80,
                    right: -80,
                    child: Image.asset(
                      'assets/adopt.png',
                      height: 300,
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ContainerBox(
                      title: "Vetenary",
                      color: Colors.lightBlueAccent,
                      icon: FontAwesomeIcons.userDoctor,
                      onTap: () {
                        // Navigate to adopt page
                      },
                    ),
                    const SizedBox(width: 10),
                    ContainerBox(
                      title: "Donate",
                      color: Colors.green,
                      icon: Icons.favorite,
                      onTap: () {
                        // Navigate to donate page
                      },
                    ),
                    const SizedBox(width: 10),
                    ContainerBox(
                      title: "Volunteer",
                      color: Colors.orange,
                      icon: Icons.volunteer_activism,
                      onTap: () {
                        // Navigate to volunteer page
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ContainerBox extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const ContainerBox({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
