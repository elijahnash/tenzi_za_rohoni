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
  @override
  void initState() {
    super.initState();
    widget.favouritesList.sort();
  }

  // Future<void> savefavourites() async {
  //   // Save favourites to shared preferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> favouritesStringList =
  //       widget.favouritesList.map((int item) => item.toString()).toList();
  //   prefs.setStringList('favourites', favouritesStringList);
  // }

  void onPressed(index) {
    setState(() {
      widget.iconButtonPressed(widget.itemList!
          .indexOf(widget.itemList![widget.favouritesList[index]]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nyimbo Pendwa"),
      ),
      body: ListView.builder(
        itemCount: widget.favouritesList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: IconButton(
              icon: Icon(
                widget.favouritesList.contains(widget.favouritesList[index])
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                    widget.favouritesList.contains(widget.favouritesList[index])
                        ? Colors.red
                        : Colors.grey,
              ),
              onPressed: () {
                onPressed(widget.favouritesList[index]);
                // setState(() {
                //   if (favouritesList.contains(index)) {
                //     favouritesList.remove(index);
                //   } else {
                //     favouritesList.add(index);
                //   }
                // });
                // savefavourites(); // Save the updated favourites list
              },
            ),
            title:
                Text(widget.itemList![widget.favouritesList[index]]['title']),
            subtitle: Text(
                widget.itemList![widget.favouritesList[index]]['subtitle']),
            leading: CircleAvatar(
              backgroundColor: Colors.amber[500],
              child: Text(
                (widget.itemList![widget.favouritesList[index]]['song_number'])
                    .toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            onTap: () {
              // Navigate to a new page with the item's details as arguments
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    item: widget.itemList![widget.favouritesList[index]],
                    favouritesList: const [],
                    itemList: const [],
                    iconButtonPressed: (void value) {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
