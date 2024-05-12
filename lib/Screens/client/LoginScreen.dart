import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/SignUpScreen.dart';
import 'package:freelanceapp/Screens/client/clientHomeScreen.dart';
import 'package:freelanceapp/Screens/landingScreen.dart';
import 'package:freelanceapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String message = "";
  String password = "";
  String gmail = "";
  bool isPasswordVisible = false;
  bool isEmailCheck = false;
  Color myColor = const Color(0xFF01696E);

  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  var passwords = TextEditingController();

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LandingScreen()),
            );
          },
        ),
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
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
    var gmail = t.text.toString();
    var password = passwords.text.toString();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("gmail", gmail);
    prefs.setString("password", password);
    bool isgmailEmpty = t.text.isEmpty;
    bool isPasswordEmpty = passwords.text.isEmpty;

    if (!isgmailEmpty && !isPasswordEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClientHomeScreen()),
      );
    } else {
      // Show alert for empty fields
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Please fill in both gmail and password fields."),
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
      password = getPass ?? '';
    });
  }

  void onSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }
}
