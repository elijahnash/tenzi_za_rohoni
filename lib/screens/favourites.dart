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
      ),
      body: favourites.isEmpty ? const HakunaNyimboPendwa() : nyimboPendwa(),
    );
  }

  ListView nyimboPendwa() {
    return ListView.builder(
      itemCount: favourites.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
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
          ),
          title: Text(widget.itemList![favourites[index]]['title']),
          subtitle: Text(widget.itemList![favourites[index]]['subtitle']),
          leading: CircleAvatar(
            backgroundColor: Colors.amber[500],
            child: Text(
              (widget.itemList![favourites[index]]['song_number']).toString(),
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
                  item: widget.itemList![favourites[index]],
                  favouritesList: favourites,
                  itemList: widget.itemList,
                  iconButtonPressed: onPressed,
                ),
              ),
            );
          },
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.heart_broken,
            size: 200,
            color: Colors.black12,
          ),
          Text("Ongeza nyimbo kwa"),
          Text(
            "Nyimbo Pedwa",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
