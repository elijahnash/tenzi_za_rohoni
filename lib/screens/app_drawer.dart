import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber[600],
            ),
            child: const Text(
              'Tenzi za Rohoni',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Tathmini'),
            onTap: () {
              // Navigate to the home screen or any other desired screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Nyimbo Pendwa'),
            onTap: () {
              // Navigate to the home screen or any other desired screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Mipangilio'),
            onTap: () {
              // Navigate to the home screen or any other desired screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Sambaza App'),
            onTap: () {
              // Navigate to the home screen or any other desired screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Kuhusu'),
            onTap: () {
              // Navigate to the home screen or any other desired screen
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more ListTiles for other options in the drawer
        ],
      ),
    );
  }
}
