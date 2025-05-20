import 'package:flutter/material.dart';
import 'package:pet_o_care/homepage.dart';
import 'package:pet_o_care/services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  bool isPasswordHidden = true;
  final AuthServices _authservice = AuthServices();

  void _signup() async {
    setState(() {
      isLoading = true;
    });

    final String result = await _authservice.signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    if(result == "success"){
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User signed up successfully")),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/petAndParent.png'),
              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'Name',
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'Email',
                ),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              const SizedBox( height : 10),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                }, 
                child: Text("Sign Up"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
