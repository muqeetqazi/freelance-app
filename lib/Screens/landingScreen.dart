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
        title: const Text('Welcome to FreelanceApp'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Join FreelanceApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
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
    Navigator.pushReplacement(
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
