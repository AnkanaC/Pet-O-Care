import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future <String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String result = "An error occurred";
    try {
      if(email.isNotEmpty && password.isNotEmpty && name.isNotEmpty){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

      // Store user data in Firestore
      await _firestore.collection('userData').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': userCredential.user!.uid,
        'score': 0,
      });
      result = "User registered successfully";
      } else {
        result = "Please fill all fields";
      }
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "An error occurred";
    try {
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = "User signed in successfully";
      } else {
        result = "Please fill all fields";
      }
    } catch (e) {
      return e.toString();
    }
    return result;
  }
}