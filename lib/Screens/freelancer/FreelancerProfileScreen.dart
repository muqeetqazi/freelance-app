import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/EditProfileScreen.dart';
import 'package:image_picker/image_picker.dart';

class FreelancerProfileScreen extends StatefulWidget {
  @override
  FreelancerProfileScreenState createState() => FreelancerProfileScreenState();
}

class FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _image;
  final ImagePicker picker = ImagePicker();

  String firstName = '';
  String lastName = '';
  String email = '';
  String? profilePictureUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();

      if (userData.exists) {
        setState(() {
          try {
            firstName = userData.get('firstName') ?? '';
          } catch (e) {
            print('Field "firstName" does not exist in the document: $e');
          }

          try {
            lastName = userData.get('lastName') ?? '';
          } catch (e) {
            print('Field "lastName" does not exist in the document: $e');
          }

          try {
            email = userData.get('email') ?? '';
          } catch (e) {
            print('Field "email" does not exist in the document: $e');
          }

          try {
            profilePictureUrl = userData.get('profilePicture') ?? null;
          } catch (e) {
            print('Field "profilePicture" does not exist in the document: $e');
          }
        });
      } else {
        // Handle the case where the document does not exist
        print('User document does not exist');
        setState(() {
          firstName = '';
          lastName = '';
          email = '';
        });
      }
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Uploading the image to Firebase Storage
      try {
        String fileName = 'profile_pictures/${user!.uid}.png';
        await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
        String downloadURL =
            await FirebaseStorage.instance.ref(fileName).getDownloadURL();

        // Saving the download URL to Firestore
        setState(() {
          _image = imageFile;
          profilePictureUrl = downloadURL;
        });

        await _firestore.collection('users').doc(user!.uid).update({
          'profilePicture': downloadURL,
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : profilePictureUrl != null
                          ? NetworkImage(profilePictureUrl!) as ImageProvider
                          : AssetImage('assets/default_profile.png'),
                  child: _image == null && profilePictureUrl == null
                      ? Icon(Icons.add_a_photo, size: 50, color: Colors.white70)
                      : null, // Show add photo icon if no image selected
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                '$firstName $lastName',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Center(
              child: Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 30),
            Divider(
              thickness: 1,
              color: Colors.grey[300],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      firstName: firstName,
                      lastName: lastName,
                      email: email,
                    ),
                  ),
                ).then((_) => _loadUserData()); // Refresh data on return
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Edit Your Profile',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
