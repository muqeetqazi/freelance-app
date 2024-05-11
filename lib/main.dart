import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/LoginScreen.dart';

import 'package:freelanceapp/Screens/client/SignUpScreen.dart';
import 'package:freelanceapp/Screens/client/clientHomeScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/client/LoginScreen": (context) => LoginScreen(),
        "/client/SignUpScreen": (context) => SignUpScreen(),
        "/landingScreen": (context) => LandingScreen(),
        "/FreelanceLoginScreen": (context) => FreelanceLoginScreen(),
      },
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "";
  static const String Firstime = "";
  @override
  void initState() {
    super.initState();
    wheretogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Welcome to My App!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void wheretogo() async {
    var SharePref = await SharedPreferences.getInstance();
    var isLoggin = SharePref.getBool(KEYLOGIN);
    // var isFirstLogin = SharePref.get(KEYFIRST);
    SharePref.getBool(Firstime);
    Timer(Duration(seconds: 3), () {
      if (Firstime == null && Firstime == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingScreen()));
      } else {
        if (isLoggin != null && isLoggin) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ClientHomeScreen()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }
    });
  }
}
