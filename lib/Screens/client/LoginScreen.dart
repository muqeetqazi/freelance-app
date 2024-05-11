import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/client/clientHomeScreen.dart';
import 'package:freelanceapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String message = "";
  String password = "";
  String gmail = "";
  bool isPasswordVisible = false;
  bool isEmailCheck = false;
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  var passwords = TextEditingController();

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
            Navigator.of(context).pop();
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
        child: Column(
          children: [
            Container(
              width: 300,
              height: 150,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: t,
                obscureText: !isEmailCheck,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Enter your gmail :",
                ),
              ),
            ),
            Container(
              height: 11,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: passwords,
                obscureText: !isPasswordVisible, // Toggle password visibility
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.red.shade300,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: Icon(Icons.key),
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
                  hintText: "Enter your Password",
                ),
              ),
            ),
            ElevatedButton(onPressed: onPressButton, child: Text("Login")),
            SizedBox(height: 11),
            Text(gmail),
            SizedBox(height: 11),
            Text(password),
          ],
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
}
