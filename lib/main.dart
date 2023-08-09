import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenzi_za_rohoni/screens/app_drawer.dart';
import 'package:tenzi_za_rohoni/screens/details_page.dart';
import 'package:tenzi_za_rohoni/utils/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tenzi za Rohoni',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const ClickableListScreen(),
    );
  }
}

class ClickableListScreen extends StatefulWidget {
  const ClickableListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClickableListScreenState createState() => _ClickableListScreenState();
}

class _ClickableListScreenState extends State<ClickableListScreen> {
  List<Map<String, dynamic>>? itemList; // Make itemList nullable
  List<int> favoritesList = [];
  List<Map<String, dynamic>> _searchResults = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadJsonData(); // Call the method to load JSON data
    loadFavourites();
  }

  // Method to update the search results
  void _updateSearchResults(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isNotEmpty) {
        _searchResults = SongSearch.searchSongs(itemList!, _searchQuery);
      } else {
        _searchResults.clear();
      }
    });
  }

  Future<void> loadFavourites() async {
    // Load favorites from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favouritesString = prefs.getString('favourites') ?? '[]';

    setState(() {
      favoritesList = List<int>.from(json.decode(favouritesString));
    });
  }

  Future<void> saveFavorites() async {
    // Save favorites to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favoritesString = json.encode(favoritesList);

    prefs.setString('favorites', favoritesString);
  }

  Future<void> loadJsonData() async {
    // Load JSON data from the external file
    String jsonData = await rootBundle.loadString('assets/tenzi.json');

    // Parse JSON and convert it into a List of items
    setState(() {
      itemList = json.decode(jsonData).cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tenzi za Rohoni'),
          backgroundColor: Colors.amber[600],
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.amber[600],
          ), // Show a loading indicator while loading the JSON data
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenzi za Rohoni'),
        backgroundColor: Colors.amber[600],
        actions: [
          // Add the search icon button to the AppBar
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SongSearchDelegate(
                  itemList: itemList!,
                  searchResults: _searchResults,
                  searchQuery: _searchQuery,
                  updateSearchResults: _updateSearchResults,
                ),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: itemList!.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: IconButton(
              icon: Icon(
                favoritesList.contains(index)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoritesList.contains(index) ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (favoritesList.contains(index)) {
                    favoritesList.remove(index);
                  } else {
                    favoritesList.add(index);
                  }
                });
                saveFavorites(); // Save the updated favorites list
              },
            ),
            title: Text(itemList![index]['title']),
            subtitle: Text(itemList![index]['subtitle']),
            leading: CircleAvatar(
              backgroundColor: Colors.amber[500],
              child: Text(
                (itemList![index]['song_number']).toString(),
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
                    item: itemList![index],
                    favoritesList: favoritesList,
                    itemList: itemList,
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
