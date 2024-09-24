import 'package:flutter/material.dart';

import '../screens/details_page.dart';

class SongSearch {
  static List<Map<String, dynamic>> searchSongs(
    List<Map<String, dynamic>> itemList,
    String query,
  ) {
    return itemList
        .where((item) =>
            item['title'].toLowerCase().contains(query.toLowerCase()) ||
            item['subtitle'].toLowerCase().contains(query.toLowerCase()) ||
            item['song_number'].toString().contains(query))
        .toList();
  }

  static List<Widget> buildSearchResults(
    List<Map<String, dynamic>> searchResults,
    Function(Map<String, dynamic>) onTap,
  ) {
    return searchResults.map((item) {
      return ListTile(
        title: Text(item['title']),
        subtitle: Text(item['subtitle']),
        onTap: () => onTap(item),
        leading: CircleAvatar(
          backgroundColor: Colors.amber[500],
          child: Text(
            (item['song_number']).toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList();
  }

  static List<Widget> buildSearchSuggestions(
    List<Map<String, dynamic>> searchSuggestions,
    Function(String) onTap,
  ) {
    return searchSuggestions.map((item) {
      return ListTile(
        title: Text(item['title']),
        subtitle: Text(item['subtitle']),
        leading: CircleAvatar(
          backgroundColor: Colors.amber[500],
          child: Text(
            (item['song_number']).toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () => onTap(item['title']),
      );
    }).toList();
  }
}

// Custom SearchDelegate for song search
class SongSearchDelegate extends SearchDelegate<Map<String, dynamic>> {
  final List<Map<String, dynamic>> itemList;
  final List<int> favouritesList;
  final List<Map<String, dynamic>> searchResults;
  final String searchQuery;
  final Function(String) updateSearchResults;
  final ValueChanged<void> iconButtonPressed;

  SongSearchDelegate({
    required this.itemList,
    required this.favouritesList,
    required this.searchResults,
    required this.searchQuery,
    required this.updateSearchResults,
    required this.iconButtonPressed,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // Add the "Clear" button
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // Clear the search query
          query = '';
          // Update the search results with an empty query
          updateSearchResults('');
        },
      ),
    ];
  }

  @override
  String get searchFieldLabel => 'Tafuta nyimbo';

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Close the search delegate and return to the previous screen
        close(context, <String, dynamic>{});
      },
    );
  }

  // @override
  // Widget buildResults(BuildContext context) {
  //   // Filter the itemList based on the search query
  //   final List<Map<String, dynamic>> searchResults =
  //       SongSearch.searchSongs(itemList, query);

  //   return ListView.builder(
  //     itemCount: searchResults.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         title: Text(searchResults[index]['title']),
  //         subtitle: Text(searchResults[index]['subtitle']),
  //         leading: CircleAvatar(
  //           backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  //           child: Text(
  //             (searchResults[index]['song_number']).toString(),
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Theme.of(context).colorScheme.onPrimaryContainer,
  //             ),
  //           ),
  //         ),
  //         onTap: () {
  //           // Navigate to the DetailPage and pass the selected song details
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => DetailPage(
  //                 item: searchResults[index],
  //                 favouritesList: favouritesList,
  //                 itemList: itemList,
  //                 iconButtonPressed: iconButtonPressed,
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Generate search suggestions based on the query
    final List<Map<String, dynamic>> searchSuggestions =
        SongSearch.searchSongs(itemList, query);

    return ListView.builder(
      itemCount: searchSuggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(searchSuggestions[index]['title']),
          subtitle: Text(searchSuggestions[index]['subtitle']),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              (searchSuggestions[index]['song_number']).toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  item: searchSuggestions[index],
                  favouritesList: favouritesList,
                  itemList: itemList,
                  iconButtonPressed: iconButtonPressed,
                ),
              ),
            );
            // // Update the search query and search results with the selected suggestion
            // updateSearchResults(searchSuggestions[index]['title']);
            // // Show the selected suggestion as the current search query
            // showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
