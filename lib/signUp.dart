import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_o_care/login.dart';
import 'package:pet_o_care/services/auth_services.dart';
import 'package:pet_o_care/verification.dart';

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

    setState(() {
      isLoading = false;
    });

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WaitingVerificationScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Something went wrong')),
      );
    }
  }

  InputDecoration getInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white12,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.orange),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Cat Image behind the signup container
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: IgnorePointer(
              // Prevents the image from blocking interaction
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: OverflowBox(
                    maxHeight: 300,
                    maxWidth: 300,
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/cat.png', fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),

          // Top Paw Decoration
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/orangePaw.png', width: 100, height: 100),
          ),

          // Main Form
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome to',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Pet-O-Care',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF8D5C),
                      fontFamily: 'Comic Sans MS',
                    ),
                  ),
                  const SizedBox(height: 140), // space so image overlaps nicely
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(top: 115),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC25E39),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.asset(
                              'assets/orangePaw.png',
                              width: 30,
                              height: 30,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Name',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: getInputDecoration('Enter your name'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: getInputDecoration('Enter your email'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: passwordController,
                          obscureText: isPasswordHidden,
                          style: const TextStyle(color: Colors.white),
                          decoration: getInputDecoration(
                            'Enter your password',
                          ).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: OutlinedButton(
                            onPressed: isLoading ? null : _signup,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 12,
                              ),
                            ),
                            child:
                                isLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
