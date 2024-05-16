import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy project data for demonstration
    final List<Project> projects = [
      Project(
        title: "Mobile App Development",
        description: "Develop a mobile app for e-commerce",
        budget: "\$5000",
        deadline: "2024-06-01",
      ),
      Project(
        title: "Website Redesign",
        description: "Redesign the company website for better UX",
        budget: "\$3000",
        deadline: "2024-07-15",
      ),
      Project(
        title: "API Integration",
        description: "Integrate third-party APIs into the existing system",
        budget: "\$2000",
        deadline: "2024-05-30",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    project.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Budget: ${project.budget}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Deadline: ${project.deadline}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Implement project application or view more details
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Apply Now'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String budget;
  final String deadline;

  Project({
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
  });
}
