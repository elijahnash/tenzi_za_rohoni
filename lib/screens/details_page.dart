import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../utils/share.dart';

class DetailPage extends StatefulWidget {
  final List<Map<String, dynamic>>? itemList;
  final Map<String, dynamic> item;
  final List<int> favouritesList;
  final ValueChanged<void> iconButtonPressed;

  const DetailPage({
    super.key,
    required this.item,
    required this.favouritesList,
    required this.itemList,
    required this.iconButtonPressed,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void onPressed() {
    setState(() {
      widget.iconButtonPressed(widget.itemList!.indexOf(widget.item));
    });
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.item['song_number']}. ${widget.item['title']}"),
        backgroundColor: Colors.amber[600],
        actions: [
          // Add the share icon button to the AppBar
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => SongShare.shareSongDetails(
              widget.item,
            ), // Call the shareSongDetails method
          ),
        ],
      ),
      body: ListView(
        children: [
          for (var index = 0; index <= widget.item.length - 4; index++)
            if (widget.item.containsKey('stanza_$index')) ...[
              if (index == 2) ...[
                if (widget.item.containsKey('chorus_$index'))
                  ...[]
                else ...[
                  for (String line in widget.item['chorus'])
                    Text(
                      line,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.amber[900],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  )
                ]
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
              if (widget.item['song_number'] == 140 ||
                  widget.item['song_number'] == 142 ||
                  widget.item['song_number'] == 145)
                ...[]
              else ...[
                const SizedBox(
                  height: 20,
                ),
              ],
              if (widget.item.containsKey('chorus_$index')) ...[
                for (String line in widget.item['chorus_$index'])
                  Text(
                    line,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.amber[900],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                )
              ]
            ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressed();
        },
        tooltip: "Nyimbo Pendwa",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        shape: const CircleBorder(),
        child: Icon(
          widget.favouritesList.contains(widget.itemList!.indexOf(widget.item))
              ? Icons.favorite
              : Icons.favorite_border,
          color: widget.favouritesList
                  .contains(widget.itemList!.indexOf(widget.item))
              ? Colors.red
              : Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
