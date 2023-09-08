import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteSongs extends StatefulWidget {
  const FavouriteSongs({super.key});

  @override
  State<FavouriteSongs> createState() => _FavouriteSongsState();
}

class _FavouriteSongsState extends State<FavouriteSongs> {
  List favouritesList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveFavorites() async {
    // Save favorites to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoritesString = json.encode(favouritesList);

    prefs.setString('favorites', favoritesString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nyimbo Pendwa"),
      ),
      body: ListView.builder(
        itemCount: favouritesList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: IconButton(
              icon: Icon(
                favouritesList.contains(index)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                    favouritesList.contains(index) ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // setState(() {
                //   if (favouritesList.contains(index)) {
                //     favouritesList.remove(index);
                //   } else {
                //     favouritesList.add(index);
                //   }
                // });
                // saveFavorites(); // Save the updated favorites list
              },
            ),
            title: Text(favouritesList[index]['title']),
            subtitle: Text(favouritesList[index]['subtitle']),
            leading: CircleAvatar(
              backgroundColor: Colors.amber[500],
              child: Text(
                (favouritesList[index]['song_number']).toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            onTap: () {
              // Navigate to a new page with the item's details as arguments
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailPage(
              //       item: favouritesList[index],
              //       favoritesList: const [],
              //       itemList: const [],
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
