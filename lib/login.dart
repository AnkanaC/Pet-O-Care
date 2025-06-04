import 'package:flutter/material.dart';
import 'package:pet_o_care/navigationBar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          children : [
            ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Navigationbar()
                  )
                );
              }, 
              child: Text('Login'),
            )
          ]
        ),
      )
    );
  }
}