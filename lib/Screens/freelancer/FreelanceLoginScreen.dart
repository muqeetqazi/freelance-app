import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelancerHomeScreen.dart';
import 'package:freelanceapp/Screens/freelancer/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreelanceLoginScreen extends StatefulWidget {
  const FreelanceLoginScreen({Key? key}) : super(key: key);

  @override
  State<FreelanceLoginScreen> createState() => _FreelanceLoginScreenState();
}

class _FreelanceLoginScreenState extends State<FreelanceLoginScreen> {
  String message = "";
  String gmail = "";
  bool isPasswordVisible = false;
  Color myColor = const Color(0xFF01696E);

  TextEditingController t = TextEditingController();
  TextEditingController passwords = TextEditingController();

  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  controller: t,
                  onChanged: (value) {
                    setState(() {
                      isEmailFocused = value.isNotEmpty;
                    });
                  },
                  onTap: () {
                    setState(() {
                      isEmailFocused = true;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Gmail',
                    labelStyle: TextStyle(
                      color: isEmailFocused ? myColor : Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isEmailFocused ? myColor : Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: myColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              Container(
                width: 300,
                child: TextField(
                  controller: passwords,
                  obscureText: !isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      isPasswordFocused = value.isNotEmpty;
                    });
                  },
                  onTap: () {
                    setState(() {
                      isPasswordFocused = true;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: isPasswordFocused ? myColor : Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isPasswordFocused ? myColor : Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: myColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 11),
              ElevatedButton(
                onPressed: onPressButton,
                child: Text(
                  "Login",
                ),
              ),
              SizedBox(height: 11),
              GestureDetector(
                onTap: onSignup,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Sign up',
                      style: TextStyle(
                        color: myColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressButton() async {
    var gmail = t.text.toString();
    var userPassword = passwords.text.toString();
    bool isGmailEmpty = t.text.isEmpty;
    bool isPasswordEmpty = passwords.text.isEmpty;

    if (!isGmailEmpty && !isPasswordEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: gmail, password: userPassword);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('You are Logged in')));
        redirectToHomeScreen(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No user Found with this Email')));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password did not match')));
        }
      }
    } else {
      // Show alert for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Please fill in both Gmail and Password fields."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getgmail = prefs.getString("gmail");
    var getPass = prefs.getString("password");
    setState(() {
      gmail = getgmail ?? '';
      // Remove the line below to fix the error
      // password = getPass ?? '';
    });
  }

  void onSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FreelanceSignUpScreen()),
    );
  }

  void redirectToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FreelancerHomeScreen()),
    );
  }
}
