import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freelanceapp/Screens/client/LoginScreen.dart';
import 'package:freelanceapp/Screens/client/SignUpScreen.dart';
import 'package:freelanceapp/Screens/client/clientHomeScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/freelancer/SignUpScreen.dart';
import 'package:freelanceapp/Screens/freelancer/freelancerHomeScreen.dart';
import 'package:freelanceapp/Screens/landingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/client/SignUpScreen": (context) => ClientSignUpScreen(),
        "/landingScreen": (context) => LandingScreen(),
        "/freelancer/FreelanceLoginScreen": (context) => FreelanceLoginScreen(),
        "/freelancer/FreelanceSignUpScreen": (context) =>
            FreelanceSignUpScreen(),
        "/freelancer/FreelancerHomeScreen": (context) => FreelancerHomeScreen(),
        "/client/ClientHomeScreen": (context) => ClientHomeScreen(),
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
  static const String Firstime = "";
  static const String isClientLogin = "";
  static const String isClientEntry = "";
  static const String isFreelanceEntry = "";
  static const String isFreelancerLogin = "";
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
            SizedBox(height: 0),
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
    var isClient = SharePref.getBool(isClientLogin);
    var isFreelanceEntryval = SharePref.getBool(isFreelanceEntry);
    var isClientEntryVal = SharePref.getBool(isClientEntry);
    var isFreelance = SharePref.getBool(isFreelancerLogin);
    var isFirstLogin = SharePref.getBool(Firstime);
    Timer(Duration(seconds: 4), () {
      /*
      if (isFirstLogin == null || isFirstLogin == false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingScreen()));
      }
      if (isFirstLogin == true) {
        if (isClientEntryVal == true) {
          if (isClient == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ClientHomeScreen()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
        if (isFreelanceEntryval == true) {
          if (isFreelance == true) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FreelancerHomeScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FreelanceLoginScreen()));
          }
        }
      }
    */
      if (isFirstLogin == null || isFirstLogin == false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingScreen()));
      }
      if (isFirstLogin == true) {
        if (isClientEntryVal == true) {
          if (isClient == true) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ClientHomeScreen()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
        if (isFreelanceEntryval == true) {
          if (isFreelance == true &&
              isFreelance != false &&
              isFreelance != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FreelancerHomeScreen()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => FreelanceLoginScreen()));
          }
        }
      }
    });
  }
}
