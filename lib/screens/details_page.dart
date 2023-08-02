import 'package:flutter/material.dart';

import '../share.dart';

class DetailPage extends StatefulWidget {
  final List<Map<String, dynamic>>? itemList;
  final Map<String, dynamic> item;
  final List<int> favoritesList;

  const DetailPage({
    super.key,
    required this.item,
    required this.favoritesList,
    required this.itemList,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLiked() {
    return widget.favoritesList.contains(widget.itemList!.indexOf(widget.item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.item['song_number']}. ${widget.item['title']}"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 0),
        actions: [
          // Add the share icon button to the AppBar
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => SongShare.shareSongDetails(
                widget.item), // Call the shareSongDetails method
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var index = 0; index <= widget.item.length - 4; index++)
            if (widget.item.containsKey('stanza_$index')) ...[
              if (index == 2) ...[
                for (String line in widget.item['chorus'])
                  Text(
                    line,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.amber[900]),
                  ),
                const SizedBox(
                  height: 20,
                )
              ],
              Text(
                '$index.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[900],
                    fontSize: 18),
              ),
              for (String line in widget.item['stanza_$index'])
                Text(
                  line,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              const SizedBox(
                height: 20,
              )
            ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (widget.favoritesList
                .contains(widget.itemList!.indexOf(widget.item))) {
              widget.favoritesList
                  .remove(widget.itemList!.indexOf(widget.item));
            } else {
              widget.favoritesList.add(widget.itemList!.indexOf(widget.item));
            }
          });
        },
        tooltip: "Favourites",
        backgroundColor: Colors.amber[50],
        child: Icon(
          isLiked() ? Icons.favorite : Icons.favorite_border,
          color: isLiked() ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
