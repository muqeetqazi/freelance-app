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
  String name = "";

  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  var passwords = TextEditingController();
  @override
  void initState() {
    super.initState();
    getValue();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: Colors.red.shade300, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {
                      print("Icon pressed");
                    },
                  ),
                  hintText: "Enter your Name :",
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
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: Colors.red.shade300, width: 2)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.key),
                      onPressed: () {
                        print("password icon pressed");
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {},
                    ),
                    hintText: "Enter your Password"),
              ),
            ),
            ElevatedButton(onPressed: onPressBotton, child: Text("login !")),
            SizedBox(
              height: 11,
            ),
            Text(name),
            SizedBox(
              height: 11,
            ),
            Text(password)
          ],
        ),
      ),
    );
  }

  void onPressBotton() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashScreenState.KEYLOGIN, true);
    var name = t.text.toString();
    var password = passwords.text.toString();
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name);
    prefs.setString("password", password);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ClientHomeScreen()));
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString("name");
    var getPass = prefs.getString("password");
    setState(() {
      name = getName ?? '';
      password = getPass ?? '';
    });
  }
}
