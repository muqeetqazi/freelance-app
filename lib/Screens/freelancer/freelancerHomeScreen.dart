import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceLoginScreen.dart';
import 'package:freelanceapp/Screens/freelancer/FreelanceProject.dart';

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
              ),
              child: Text('View Projects'),
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
              ),
              child: Text('View Profile'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FreelanceLoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class FreelancerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final String name = "John Doe";
    final String bio =
        "Experienced freelance developer with expertise in mobile app development.";
    final List<String> skills = ["Flutter", "React Native", "Node.js"];
    final int rating = 4;
    final int completedProjects = 20;

    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture (You can replace this with an actual profile picture widget)
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/my.png'),
            ),
            SizedBox(height: 16),
            // Freelancer Name
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Freelancer Bio
            Text(
              bio,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Skills
            Text(
              'Skills:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: skills.map((skill) {
                return Chip(
                  label: Text(skill),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Rating
            Text(
              'Rating: $rating',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Completed Projects
            Text(
              'Completed Projects: $completedProjects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              color: Colors.blue,
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
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FreelanceLoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
