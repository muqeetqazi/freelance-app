// same bhai UI ka dekh laye
// authentication wali screen ha
// routing check kr laye ka kahain load hoti ha or
//login/signup successful hona pa kaha jati wo authfunctions ma redirectToClientHomeScreen() pa decide ho raha

import 'package:flutter/material.dart';
import 'package:freelanceapp/services/functions/authFunctions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String fullname = '';
  String selectedIndustry = '';
  List<String> industries = [
    'Education',
    'Commute',
    'Delivery',
    'Medicine',
    // Add more industries as needed
  ];
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(login ? 'Login' : 'Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !login
                  ? TextFormField(
                      key: ValueKey('fullname'),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Full Name';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          fullname = value!;
                        });
                      },
                    )
                  : SizedBox(), // Hide Full Name field if logging in
              SizedBox(height: 20),
              !login
                  ? DropdownButtonFormField<String>(
                      value: selectedIndustry.isEmpty ? null : selectedIndustry,
                      hint: Text('Select Industry'),
                      items: industries.map((String industry) {
                        return DropdownMenuItem<String>(
                          value: industry,
                          child: Text(industry),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedIndustry = value!;
                        });
                      },
                    )
                  : SizedBox(), // Hide Industry dropdown if logging in
              SizedBox(height: 20),
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                key: ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide password
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Please Enter Password of min length 6';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (login) {
                      AuthServices.signinCompany(email, password, context);
                    } else {
                      AuthServices.signupCompany(
                          email, password, fullname, selectedIndustry, context);
                    }
                  }
                },
                child: Text(login ? 'Login' : 'Sign Up'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    login = !login;
                  });
                },
                child: Text(login
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
