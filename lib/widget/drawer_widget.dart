import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yodi/screen/auth_screen.dart';

import '../bloc/user/user_bloc.dart';
import '../utils/auth.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Text("Loading...");
        } else if (state is UserLoadSuccess) {
          final user = state.user[0];

          return Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user.username, style: const TextStyle(color: Color.fromARGB(255, 61, 61, 61)),),
                  accountEmail: Text(user.email!, style: const TextStyle(color: Color.fromARGB(255, 61, 61, 61)),),
                  currentAccountPicture: const CircleAvatar(
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

                // logout button
                ListTile(
                  title: const Text("Log Out"),
                  trailing: const Icon(Icons.exit_to_app),
                  // ignore: avoid_print
                  onTap: () {
                    Auth().deleteToken();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Text('FATAL ERROR (FISH LIST)');
        }
      },
    );
  }
}