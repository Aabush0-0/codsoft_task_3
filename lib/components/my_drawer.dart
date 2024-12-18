import 'package:flutter/material.dart';
import 'package:music_app/pages/settings.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 45,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
            ),
            child: ListTile(
              //home
              leading: const Icon(Icons.home),
              title: const Text('HOME'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          //settings
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('SETTINGS'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
