import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceProject.dart';
import 'package:freelanceapp/Screens/freelancer/FreelancerProfileScreen.dart';
import 'package:freelanceapp/Screens/freelancer/creategig.dart';
import 'package:freelanceapp/Screens/freelancer/myGigs.dart';
import 'package:freelanceapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

Color myColor = const Color(0xFF01696E);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelancer Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FreelancerHomeScreen(),
    );
  }
}

class FreelancerHomeScreen extends StatelessWidget {
  const FreelancerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freelancer Home'),
        backgroundColor: myColor,
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to Freelancer Home!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to view available projects or jobs
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: myColor,
              ),
              child:
                  Text('View Projects', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FreelancerProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: myColor,
              ),
              child:
                  Text('View Profile', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateGigScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: myColor,
              ),
              child: Text('Create Gigs', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyGigsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: myColor,
              ),
              child: Text('View Gigs', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: myColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FreelancerProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text('Projects'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              onLogOut(context);
            },
          ),
        ],
      ),
    );
  }
}

void onLogOut(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashScreenState.isFreelancerLogin, false);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => FreelanceLoginScreen()));
}
