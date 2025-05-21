import 'package:flutter/material.dart';
import 'package:pet_o_care/homepage.dart';
import 'package:pet_o_care/navigationBar.dart';
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

  final TextEditingController _nameController = TextEditingController(text: "Ankana Chakraborty");
  final TextEditingController _emailController = TextEditingController(text: "hello@pet-o-care.com");
  final TextEditingController _passwordController = TextEditingController(text: "******");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         Image.asset('assets/petAndParent.png'),
      //         const SizedBox(height: 20),

      //         TextField(
      //           controller: nameController,
      //           decoration: const InputDecoration(
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(15)),
      //             ),
      //             labelText: 'Name',
      //           ),
      //         ),

      //         const SizedBox(height: 8),

      //         TextField(
      //           controller: emailController,
      //           decoration: const InputDecoration(
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(15)),
      //             ),
      //             labelText: 'Email',
      //           ),
      //         ),

      //         const SizedBox(height: 8),

      //         TextField(
      //           controller: passwordController,
      //           obscureText: isPasswordHidden,
      //           decoration: InputDecoration(
      //             border: const OutlineInputBorder(
      //               borderRadius: BorderRadius.all(Radius.circular(15)),
      //             ),
      //             labelText: 'Password',
      //             suffixIcon: IconButton(
      //               onPressed: () {
      //                 setState(() {
      //                   isPasswordHidden = !isPasswordHidden;
      //                 });
      //               },
      //               icon: Icon(
      //                 isPasswordHidden
      //                     ? Icons.visibility_off
      //                     : Icons.visibility,
      //               ),
      //             ),
      //           ),
      //         ),

      //         const SizedBox( height : 10),

      //         ElevatedButton(
      //           onPressed: (){
      //             //_signup();
      //             Navigator.pushReplacement(context, MaterialPageRoute(
      //               builder: (context) => Navigationbar(),
      //             ));
      //           }, 
      //           child: Text("Sign Up"),
      //           ),
      //       ],
      //     ),
      //   ),
      // ),

      body : Stack(
        children: [
          // Top left decorative dots
          
          // Top right decorative circles
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/orangePaw.png', width: 100, height: 100),
          ),
          
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Welcome text
                    const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    // Pet Shop title
                    Text(
                      'Pet-O-Care',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFF8D5C),
                        fontFamily: 'Comic Sans MS',
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Cat illustration
                    Image.asset('assets/cat.png'),
                    
                    const SizedBox(height: 30),
                    
                    // Sign up form
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC25E39),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sign Up header with paw icon
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
                          
                          // Name field
                          const Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(
                              color: Color(0xFFC25E39),
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Color(0xFFC25E39)),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Email field
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Color(0xFFC25E39),
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Color(0xFFC25E39)),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Password field
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Color(0xFFC25E39),
                              fontSize: 16,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Color(0xFFC25E39)),
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // Next button
                          Center(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Sign in link
                          Center(
                            child: RichText(
                              text: const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
