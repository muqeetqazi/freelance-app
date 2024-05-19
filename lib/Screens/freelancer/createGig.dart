// ya screen button: 'Create Gig' freelancer side pa click krna pa show krwa daye
// bhai es screen ka UI dekh laye agr behtr krna ka dil krey
// or espa submit ka buttton pr click krna pa essa 'myGigs.dart' pr pohancha daye
// es screen ki detail: categrory main data firebase sa arha or description or availability status 
// select krka, submit pa click kro to currently logged in user ka liye gigs collection ma data firebase 
// pa store ho jate , userid, ctgID, description or availablity status ka sath

import 'package:flutter/material.dart';
import 'package:freelanceapp/services/functions/gigFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGigScreen extends StatefulWidget {
  @override
  _CreateGigScreenState createState() => _CreateGigScreenState();
}

class _CreateGigScreenState extends State<CreateGigScreen> {
  String? selectedCategory;
  String description = '';
  bool isAvailable = false;
  List<DocumentSnapshot> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    List<DocumentSnapshot> result = await GigFunction.getCategories();
    setState(() {
      categories = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Gig'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: selectedCategory,
              hint: Text('Select Category'),
              items: categories.map((DocumentSnapshot category) {
                return DropdownMenuItem(
                  value: category['catId'].toString(),
                  child: Text(category['catNm']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value.toString();
                });
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Available: '),
                Checkbox(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedCategory == null || selectedCategory!.isEmpty
                  ? null
                  : () async {
                      // Call function to create gig
                      bool success = await GigFunction.createGig(
                        selectedCategory!,
                        description,
                        isAvailable,
                      );
                      if (success) {
                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gig created successfully')),
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gig creation failed')),
                        );
                      }
                    },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
