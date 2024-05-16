import 'package:flutter/material.dart';
import 'package:freelanceapp/Screens/freelancer/FreelancerProfileScreen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green[400],
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    List<Widget> menuItems = [];

    menuItems.add(UserAccountsDrawerHeader(
      accountName: const Text("Muqeet Ahmad"),
      accountEmail: const Text("muqeetahmad202@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage("assets/my.jpg"),
      ),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        image: DecorationImage(
            image: AssetImage("assets/back.jpg"), fit: BoxFit.cover),
      ),
    ));

    final Set<String> menuTitles = {
      "Profile",
    };

    menuTitles.forEach((element) {
      menuItems.add(ListTile(
        title: Text(
          element,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          Widget screen = Container();
          switch (element) {
            case "Profile":
              screen = FreelancerProfileScreen();
              break;
            default:
          }

          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    });

    return menuItems;
  }
}
