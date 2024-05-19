import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/HiringScreen.dart';
import 'package:freelanceapp/Screens/client/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Home Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClientHomeScreen(),
    );
  }
}

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Home'),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF01696E),
                  const Color(0xFF67D9E9), // Lighter shade
                ],
              ),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  'Welcome to Client Home!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton('View Jobs', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HiringScreen()),
                        );
                      }),
                      SizedBox(height: 20),
                      _buildButton('View Profile', () {
                        // Add functionality to navigate to other screens
                      }),
                      SizedBox(height: 20),
                      _buildButton('Hire freelancers', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HiringScreen()));
                      }),
                      SizedBox(height: 20),
                      _buildButton('Log Out', () {
                        onClickLogout(context);
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClickLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }
}
