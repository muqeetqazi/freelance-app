import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreelancerProfileScreen extends StatefulWidget {
  @override
  _FreelancerProfileScreenState createState() =>
      _FreelancerProfileScreenState();
}

class _FreelancerProfileScreenState extends State<FreelancerProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs
        .getString('userEmail'); // Retrieve user email from SharedPreferences

    if (userEmail != null && userEmail.isNotEmpty) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(userEmail).get();

      setState(() {
        _email = userData.get('email') ?? '';
        _firstName = userData.get('firstName') ?? '';
        _lastName = userData.get('lastName') ?? '';
        _phoneNumber = userData.get('phoneNumber') ?? '';
        _isLoading = false;

        // Set the initial values for the controllers
        _firstNameController.text = _firstName;
        _lastNameController.text = _lastName;
        _phoneNumberController.text = _phoneNumber;
      });
    } else {
      print('User email not found in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Freelancer Profile'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      _email,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _phoneNumberController,
                      labelText: 'Phone Number',
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      child: Text('Save Changes'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _oldPasswordController,
                      labelText: 'Old Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _newPasswordController,
                      labelText: 'New Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _confirmNewPasswordController,
                      labelText: 'Confirm New Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _changePassword,
                      child: Text('Change Password'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? prefixIcon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
    );
  }

  void _saveChanges() async {
    // Save changes to Firestore
    await _firestore.collection('users').doc(_email).update({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phoneNumber': _phoneNumberController.text,
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Changes saved successfully')),
    );
  }

  void _changePassword() async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmNewPassword = _confirmNewPasswordController.text;

    if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    try {
      await _user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: _user!.email!,
          password: oldPassword,
        ),
      );
      await _user?.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );
      // Clear the password fields after successful password change
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmNewPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error changing password: ${e.message}')),
      );
    }
  }
}
