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

  AppDrawer({
    super.key,
    required this.itemList,
    required this.favouritesList,
    required this.iconButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.amber[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.amber[100],
              child: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.amber[200],
                      child: Image.asset(
                        'assets/images/coverwithoutshadow.png',
                        height: 50,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tenzi za Rohoni',
                      style: TextStyle(
                        color: Colors.amber[900],
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Toleo la Kisasa',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: const Text('Tathmini',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.amber),
              onTap: () {
                Navigator.pop(context);
                inAppReview.openStoreListing();
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
              title: const Text('Nyimbo Pendwa',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.pinkAccent),
              onTap: () {
                Navigator.pop(context);
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
            // Uncomment to add settings
            // ListTile(
            //   leading: const Icon(Icons.settings, color: Colors.blueGrey),
            //   title: const Text('Mipangilio', style: TextStyle(fontWeight: FontWeight.w500)),
            //   trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueGrey),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const TenziSettings(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.green),
              title: const Text('Sambaza App',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.green),
              onTap: () {
                Navigator.pop(context);
                AppShare.shareApp();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.blueAccent),
              title: const Text('Kuhusu',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.blueAccent),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutTenzi()));
              },
            ),
            const Divider(height: 1, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  '© 2025 Tenzi za Rohoni',
                  style: TextStyle(
                    color: Colors.amber[700],
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
