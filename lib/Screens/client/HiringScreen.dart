import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/services/functions/gigFunctions.dart';
import 'package:url_launcher/url_launcher.dart';

class HiringScreen extends StatefulWidget {
  const HiringScreen({Key? key}) : super(key: key);

  @override
  _HiringScreenState createState() => _HiringScreenState();
}

class _HiringScreenState extends State<HiringScreen> {
  String? selectedCategory;
  String? selectedCategoryName;
  List<Map<String, String>> categories = [];
  List<DocumentSnapshot> gigs = [];

  final GigFunction gigFunction = GigFunction();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadGigs();
  }

  Future<void> _loadCategories() async {
    try {
      List<DocumentSnapshot> categoryDocs = await GigFunction.getCategories();
      List<Map<String, String>> loadedCategories = categoryDocs.map((doc) {
        return {
          'catId': (doc['catId'] ?? '').toString(),
          'catNm': (doc['catNm'] ?? '').toString(),
        };
      }).toList();

      setState(() {
        categories = loadedCategories;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _loadGigs() async {
    try {
      if (selectedCategory != null && selectedCategory!.isNotEmpty) {
        gigs = await gigFunction.fetchGigsByCategory(selectedCategory!);
      } else {
        List<DocumentSnapshot> allGigs = await GigFunction
            .fetchAllGigs(); // Use class name to call static method
        gigs = allGigs;
      }
      setState(() {});
    } catch (e) {
      print('Error loading gigs: $e');
    }
  }

  Future<void> _hireUser(String userEmail) async {
    if (userEmail.isNotEmpty) {
      String emailUrl =
          'mailto:$userEmail?subject=Job Application&body=Hi, I would like to hire you for my project.';
      if (await canLaunch(emailUrl)) {
        await launch(emailUrl);
      } else {
        print('Could not launch email client');
      }
    } else {
      print('User email not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hire a Freelancer',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.green.shade900,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: Text('Select Category'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['catId']!,
                  child: Text(
                    category['catNm']!,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) async {
                setState(() {
                  selectedCategory = value;
                  selectedCategoryName = categories.firstWhere(
                      (category) => category['catId'] == value)['catNm'];
                });
                await _loadGigs();
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: gigs.isEmpty
                  ? Center(
                      child: Text(
                        'No gigs available for the selected category',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: gigs.length,
                      itemBuilder: (context, index) {
                        var gig = gigs[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          color: Colors.green.shade800,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                selectedCategoryName ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                gig['gigDescription'] ?? '',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  String userEmail = gig['userId'] ?? '';
                                  _hireUser(userEmail);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Hire Me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
