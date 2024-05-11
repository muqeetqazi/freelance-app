import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Freelancer Home!',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to view available projects or jobs
              },
              child: Text('View Projects'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add functionality to view profile
              },
              child: Text('View Profile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add functionality to log out
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
