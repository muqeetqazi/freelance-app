import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelanceapp/services/functions/gigFunctions.dart';

class HiringScreen extends StatefulWidget {
  const HiringScreen({Key? key}) : super(key: key);

  @override
  _HiringScreenState createState() => _HiringScreenState();
}

class _HiringScreenState extends State<HiringScreen> {
  String? selectedCategory;
  String? selectedCategoryName;
  List<Map<String, String>> categories = [];
  GigFunction gigFunction = GigFunction();
  List<DocumentSnapshot> gigs = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiring Screen'),
      ),
      body: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedCategory,
            hint: Text('Select Category'),
            items: [
              DropdownMenuItem(
                value: null,
                child: Text('Select Category'),
              ),
              ...categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['catId']!,
                  child: Text(category['catNm']!),
                );
              }).toList(),
            ],
            onChanged: (value) async {
              setState(() {
                selectedCategory = value;
                selectedCategoryName = categories.firstWhere(
                    (category) => category['catId'] == value)?['catNm'];
              });
              if (selectedCategory != null && selectedCategory!.isNotEmpty) {
                gigs = await gigFunction.fetchGigsByCategory(selectedCategory!);
                setState(() {}); // Update the state to rebuild the widget
              }
            },
          ),
          Expanded(
            child: gigs.isEmpty
                ? Center(
                    child: Text('No gigs available for the selected category'),
                  )
                : ListView.builder(
                    itemCount: gigs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(selectedCategoryName ?? ''),
                          subtitle: Text(gigs[index]['gigDescription'] ?? ''),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Implement hire functionality
                            },
                            child: Text('Hire Me'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
