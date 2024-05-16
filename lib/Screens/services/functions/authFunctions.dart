import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/services/functions/firebaseFunctions.dart';

class AuthServices {
  static signupUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with display name and other details if needed
      await userCredential.user!.updateDisplayName('$firstName $lastName');

      // Save user information to Firestore
      await FirebaseFunctions().signUpUser(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      redirectToHomeScreen(
          context); // Redirect to home screen after successful registration
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email Provided already Exists')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('You are Logged in')));
      redirectToHomeScreen(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password did not match')));
      }
    }
  }

  static void redirectToHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FreelanceLoginScreen()),
    );
  }
}
