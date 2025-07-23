import 'package:flutter/material.dart';

import 'details_page.dart';

class FavouriteSongs extends StatefulWidget {
  final List<Map<String, dynamic>>? itemList;
  final List<int> favouritesList;
  final ValueChanged<void> iconButtonPressed;

  const FavouriteSongs(
      {super.key,
      required this.itemList,
      required this.favouritesList,
      required this.iconButtonPressed});

  @override
  State<FavouriteSongs> createState() => _FavouriteSongsState();
}

class _FavouriteSongsState extends State<FavouriteSongs> {
  List<int> favourites = [];

  @override
  void initState() {
    super.initState();
    favourites = widget.favouritesList;
    favourites.sort();
  }

  void onPressed(index) {
    setState(() {
      widget.iconButtonPressed(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nyimbo Pendwa"),
        backgroundColor: Colors.amber[600],
        foregroundColor: Colors.brown[900],
        elevation: 1,
      ),
      body: favourites.isEmpty ? const HakunaNyimboPendwa() : nyimboPendwa(),
      backgroundColor: Colors.amber[50],
    );
  }

  Widget nyimboPendwa() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: favourites.length,
      separatorBuilder: (context, idx) => const SizedBox(height: 0),
      itemBuilder: (BuildContext context, int index) {
        final item = widget.itemList![favourites[index]];
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: CircleAvatar(
              backgroundColor: Colors.amber[400],
              child: Text(
                (item['song_number']).toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            subtitle: Text(
              item['subtitle'],
              style: const TextStyle(fontSize: 14, color: Colors.brown),
            ),
            trailing: IconButton(
              icon: Icon(
                favourites.contains(favourites[index])
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favourites.contains(favourites[index])
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                onPressed(favourites[index]);
              },
              tooltip: favourites.contains(favourites[index])
                  ? 'Ondoa kwenye pendwa'
                  : 'Ongeza kwenye pendwa',
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    item: item,
                    favouritesList: favourites,
                    itemList: widget.itemList,
                    iconButtonPressed: onPressed,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class HakunaNyimboPendwa extends StatelessWidget {
  const HakunaNyimboPendwa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.heart_broken,
              size: 120,
              color: Colors.amber[100],
            ),
            const SizedBox(height: 18),
            const Text(
              "Huna nyimbo pendwa bado!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.brown),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Bonyeza alama ya moyo kwenye tenzi ili kuongeza kwenye orodha ya nyimbo pendwa zako.",
              style: TextStyle(fontSize: 15, color: Colors.brown),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
