import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/services/functions/gigFunctions.dart';

class MyGigsScreen extends StatefulWidget {
  @override
  _MyGigsScreenState createState() => _MyGigsScreenState();
}

class _MyGigsScreenState extends State<MyGigsScreen> {
  List<DocumentSnapshot> gigs = [];
  bool isLoading = true;

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
      print('Error fetching gigs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Gigs'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : gigs.isEmpty
              ? Center(child: Text('No gigs found.'))
              : ListView.builder(
                  itemCount: gigs.length,
                  itemBuilder: (context, index) {
                    var gig = gigs[index];
                    return Card(
                      child: ListTile(
                        title: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('categories')
                              .where('catId', isEqualTo: gig['catId'])
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Error");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading...");
                            }
                            if (snapshot.data!.docs.isEmpty) {
                              return Text("Category Not Found");
                            }
                            var catName = snapshot.data!.docs[0]['catNm'];
                            return Text(catName);
                          },
                        ),
                        subtitle: Text(gig['gigDescription']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: gig['available'],
                              onChanged: (value) async {
                                await GigFunction.updateGigAvailability(
                                    gig.id, value);
                                fetchGigs();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await GigFunction.deleteGig(gig.id);
                                fetchGigs();
                              },
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
