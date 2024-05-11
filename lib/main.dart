import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/LoginScreen.dart';

import 'package:freelanceapp/Screens/client/SignUpScreen.dart';
import 'package:freelanceapp/Screens/client/clientHomeScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  Color myColor = const Color(0xFF01696E);

  @override
  void initState() {
    super.initState();
    wheretogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Image.asset(
              'assets/splash.png',
              width: 400,
              height: 400,
            ),
            SizedBox(
                height:
                    0), // Add some space between the image and the loading animation
            SpinKitWave(
              // Use SpinKitWave from the package
              color: myColor, // Set the color of the animation
              size: 40.0, // Set the size of the animation
            ),
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
    Timer(Duration(seconds: 4), () {
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
