import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../utils/constans.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("hengki"),
              accountEmail: Text("hengki@mail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                  'images/logo.jpg',
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Orang"),
              subtitle: const Text("data"),
              trailing: const Icon(Icons.edit),
              // ignore: avoid_print
              onTap: () {},
            ),
            ListTile(
              title: const Text("Log Out"),
              trailing: const Icon(Icons.exit_to_app),
              // ignore: avoid_print
              onTap: () {
                Constants.prefs.setBool("loggedIn", false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      );
  }
}