import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_o_care/success_screen.dart';

class WaitingVerificationScreen extends StatefulWidget {
  const WaitingVerificationScreen({super.key});

  @override
  State<WaitingVerificationScreen> createState() => _WaitingVerificationScreenState();
}

class _WaitingVerificationScreenState extends State<WaitingVerificationScreen> {
  Timer? timer;
  int timeLeft = 120; // 2 minutes in seconds
  bool isResending = false;

  @override
  void initState() {
    super.initState();

    // Start checking every 3 seconds
    timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      var user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SuccessScreen()), // Navigate to Home
        );
      }

      // Reduce countdown
      if (timeLeft > 0) {
        setState(() {
          timeLeft -= 3;
        });
      } else {
        timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time out. Please verify and login again.')),
        );
        Navigator.pop(context); // Go back to Signup
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> resendVerificationEmail() async {
    try {
      setState(() {
        isResending = true;
      });

      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email resent! Check your inbox.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isResending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your Email'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'A verification email has been sent.\nPlease verify your email to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                'Auto checking... ⏳ ${timeLeft}s left',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: isResending ? null : resendVerificationEmail,
                icon: const Icon(Icons.refresh),
                label: isResending
                    ? const Text('Resending...')
                    : const Text('Resend Email'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: const Text('Cancel & Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
