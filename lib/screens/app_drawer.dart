import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:tenzi_za_rohoni/screens/about.dart';
import 'package:tenzi_za_rohoni/screens/favourites.dart';
import 'package:tenzi_za_rohoni/utils/share.dart';

class AppDrawer extends StatelessWidget {
  final List<Map<String, dynamic>>? itemList;
  final List<int> favouritesList;
  final ValueChanged<void> iconButtonPressed;
  final InAppReview inAppReview = InAppReview.instance;

  AppDrawer(
      {super.key,
      required this.itemList,
      required this.favouritesList,
      required this.iconButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: null,
              color: Colors.amber[50],
            ),
            child: Column(
              children: [
                Text(
                  'Tenzi za Rohoni',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber[900],
                    fontSize: 24,
                  ),
                ),
                Image.asset(
                  'assets/images/coverwshadow.png',
                  height: 100,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Tathmini'),
            onTap: () {
              Navigator.pop(context);
              inAppReview.openStoreListing();
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Nyimbo Pendwa'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteSongs(
                    favouritesList: favouritesList,
                    itemList: itemList,
                    iconButtonPressed: iconButtonPressed,
                  ),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings),
          //   title: const Text('Mipangilio'),
          //   onTap: () {
          //     Navigator.pop(context); // Close the drawer
          //     // Navigate to the home screen or any other desired screen
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const TenziSettings(),
          //       ),
          //     );
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Sambaza App'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              AppShare.shareApp();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Kuhusu'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate to the home screen or any other desired screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutTenzi()));
            },
          ),
          // Add more ListTiles for other options in the drawer
        ],
      ),
    );
  }
}
