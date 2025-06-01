import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String result = "An error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user;
        if (user != null) {
          // Store user data in Firestore
          await _firestore.collection('userData').doc(user.uid).set({
            'name': name,
            'email': email,
            'uid': user.uid,
            'score': 0,
          });
          result = "success";
        } else {
          result = "User creation failed. Please try again.";
        }
      } else {
        result = "Please fill all fields";
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          result = 'Email is already in use.';
          break;
        case 'invalid-email':
          result = 'The email address is invalid.';
          break;
        case 'weak-password':
          result = 'Password should be at least 6 characters.';
          break;
        default:
          result = e.message ?? 'Authentication error occurred.';
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "An error occurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = "User signed in successfully";
      } else {
        result = "Please fill all fields";
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          result = 'No user found for this email.';
          break;
        case 'wrong-password':
          result = 'Incorrect password.';
          break;
        case 'invalid-email':
          result = 'The email address is invalid.';
          break;
        default:
          result = e.message ?? 'Login error occurred.';
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }
}
