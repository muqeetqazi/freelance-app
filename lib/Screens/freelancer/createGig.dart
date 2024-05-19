// ya screen button: 'Create Gig' freelancer side pa click krna pa show krwa daye
// bhai es screen ka UI dekh laye agr behtr krna ka dil krey
// or espa submit ka buttton pr click krna pa essa 'myGigs.dart' pr pohancha daye
// es screen ki detail: categrory main data firebase sa arha or description or availability status
// select krka, submit pa click kro to currently logged in user ka liye gigs collection ma data firebase
// pa store ho jate , userid, ctgID, description or availablity status ka sath

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/services/functions/gigFunctions.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField(
              value: selectedCategory,
              hint: Text('Select Category'),
              items: categories.map((DocumentSnapshot category) {
                return DropdownMenuItem(
                  value: category['catId'].toString(),
                  child: Text(
                    category['catNm'],
                    style: TextStyle(fontSize: 16.0),
                  ),
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
                filled: true,
                fillColor: Colors.grey[200],
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
                Text(
                  'Available:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: 10),
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedCategory == null || selectedCategory!.isEmpty
                    ? null
                    : () async {
                        bool success = await GigFunction.createGig(
                          selectedCategory!,
                          description,
                          isAvailable,
                        );
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gig created successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gig creation failed')),
                          );
                        }
                      },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
