import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:freelanceapp/Screens/services/functions/gigFunctions.dart';

class MyGigsScreen extends StatefulWidget {
  @override
  _MyGigsScreenState createState() => _MyGigsScreenState();
}

class _MyGigsScreenState extends State<MyGigsScreen> {
  List<DocumentSnapshot> gigs = [];
  bool isLoading = true;
  Color myColor = const Color(0xFF01696E);

  @override
  void initState() {
    super.initState();
    fetchGigs();
  }

  Future<void> fetchGigs() async {
    try {
      List<DocumentSnapshot> result = await GigFunction.getGigsForUser();
      setState(() {
        gigs = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching gigs: $e')),
      );
    }
  }

  Future<String> getCategoryName(String categoryId) async {
    try {
      return await GigFunction().getCategoryName(categoryId);
    } catch (e) {
      return 'Category Not Found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Gigs'),
        backgroundColor: myColor,
      ),
      body: isLoading
          ? Center(child: SpinKitWave(color: myColor))
          : gigs.isEmpty
              ? Center(
                  child: Text(
                    'No gigs available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: gigs.length,
                  itemBuilder: (context, index) {
                    var gig = gigs[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundColor: myColor,
                                child: Icon(
                                  Icons.work,
                                  color: Colors.white,
                                ),
                              ),
                              title: FutureBuilder<String>(
                                future: getCategoryName(gig['catId']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Loading...");
                                  }
                                  if (snapshot.hasError) {
                                    return Text("Error loading category");
                                  }
                                  return Text(
                                    snapshot.data ?? "Category Not Found",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  );
                                },
                              ),
                              subtitle: Text(
                                gig['gigDescription'],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Switch(
                                  value: gig['available'],
                                  onChanged: (value) async {
                                    await GigFunction.updateGigAvailability(
                                        gig.id, value);
                                    fetchGigs();
                                  },
                                  activeColor: myColor,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    bool confirmed = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        title: Text('Delete Gig'),
                                        content: Text(
                                            'Are you sure you want to delete this gig?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirmed) {
                                      await GigFunction.deleteGig(gig.id);
                                      fetchGigs();
                                    }
                                  },
                                ),
                              ],
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
