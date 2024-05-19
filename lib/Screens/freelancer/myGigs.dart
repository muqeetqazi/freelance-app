// screen detail: es screen pa freelancer ki jo gigs firebase pa pari wo show hoti
// wo chahy to unha deactivate ya delete kr skta
// deactivate krna pa database ma status false ho jata false status wali gig client side pr nazar nae ayengi
// ya screen freelancer side pa 'My Gigs' button bna kr dikha daye uspa
// eska bhi UI behter krna ko dil krey to bismillah

import 'package:flutter/material.dart';
import 'package:freelanceapp/services/functions/gigFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyGigsScreen extends StatefulWidget {
  @override
  _MyGigsScreenState createState() => _MyGigsScreenState();
}

class _MyGigsScreenState extends State<MyGigsScreen> {
  late List<DocumentSnapshot> gigs;

  @override
  void initState() {
    super.initState();
    fetchGigs();
  }

  Future<void> fetchGigs() async {
    List<DocumentSnapshot> result = await GigFunction.getGigsForUser();
    setState(() {
      gigs = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Gigs'),
      ),
      body: gigs == null
          ? Center(child: CircularProgressIndicator())
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
                          return Text("Loading");
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
