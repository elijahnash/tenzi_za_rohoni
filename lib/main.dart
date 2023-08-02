import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenzi_za_rohoni/screens/details_page.dart';
import 'package:tenzi_za_rohoni/utils/header_drawer.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
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

  @override
  void initState() {
    super.initState();
    loadJsonData(); // Call the method to load JSON data
    loadFavourites();
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
          backgroundColor: Colors.amber[900],
        ),
        body: const Center(
          child:
              CircularProgressIndicator(), // Show a loading indicator while loading the JSON data
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenzi za Rohoni'),
        backgroundColor: Colors.amber[900],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: const Column(
              children: [
                HeaderDrawer(),
                // DrawerList(),
              ],
            ),
          ),
        ),
      ),
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
                (index + 1).toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
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
