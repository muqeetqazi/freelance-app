import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/LoginScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Image.asset(
              'assets/name.png', // Replace with your image asset path
              width: 150,
              height: 100, // Adjust the width as needed
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png', // Replace with your logo asset path
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _onClient(context);
              },
              child: Text(
                'Join as Client',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _onFreelancer(context);
              },
              child: Text(
                'Join as Freelancer',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClient(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('FirstTime', false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _onFreelancer(BuildContext context) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool('FirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FreelanceLoginScreen()),
    );
  }
}
