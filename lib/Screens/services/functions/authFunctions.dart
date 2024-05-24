import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/services/functions/firebaseFunctions.dart';
import 'package:freelanceapp/Screens/services/functions/gigFunctions.dart';

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
      //use defualt function kia hn UserCredential ka
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with display name and other details if needed
      await userCredential.user!.updateDisplayName('$firstName $lastName');

      // Save user information to Firestore with Gmail as document ID
      await FirebaseFunctions().signUpUser(
        userId: email, // Use Gmail as document ID
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );

      // Create a default gig for the newly registered user
      bool success = await GigFunction.createGig(
        'defaultCategoryId', // Provide default category ID here
        'Default gig description', // Provide default description here
        true, // Provide default availability status here
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')));
        redirectToHomeScreen(
            context); // Redirect to home screen after successful registration
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Gig creation failed')));
      }
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

  static Future<User?> signupUserCompanies({
    required String companyName,
    required String email,
    required String password,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      // Save company information to Firestore
      await FirebaseFirestore.instance
          .collection('companies')
          .doc(user!.uid)
          .set({
        'companyName': companyName,
        'email': email,
        'phoneNumber': phoneNumber,
      });

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> signinUserCompanies(
      String email, String password, BuildContext context) async {
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
