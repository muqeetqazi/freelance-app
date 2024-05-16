import 'package:flutter/material.dart';

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
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'),
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

void main() {
  runApp(MaterialApp(
    title: 'Freelancer Profile Demo',
    home: FreelancerProfileScreen(),
  ));
}
