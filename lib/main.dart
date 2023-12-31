import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';
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
  final RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 5,
    remindDays: 2,
    remindLaunches: 5,
    appStoreIdentifier: '',
    googlePlayIdentifier: 'ke.co.mydeals.tenzi_za_rohoni',
  );

  List<Map<String, dynamic>>? itemList;
  List<int> favouritesList = [];
  List<Map<String, dynamic>> _searchResults = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        _rateMyApp.showStarRateDialog(
          context,
          title: "Je, unafurahia Programu?",
          message: "Tafadhali tathmini App hii.",
          dialogStyle: const DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: const StarRatingOptions(),
          actionsBuilder: (context, stars) {
            return [
              TextButton(
                child: const Text('Sawa'),
                onPressed: () {
                  _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(
                      context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
        );
      }
    });
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
    // Load favourites from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> favourites = prefs
            .getStringList('favourites')
            ?.map((item) => int.parse(item))
            .toList() ??
        [];

    setState(() {
      favouritesList = favourites;
    });
  }

  Future<void> savefavourites() async {
    // Save favourites to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favouritesStringList =
        favouritesList.map((int item) => item.toString()).toList();
    prefs.setStringList('favourites', favouritesStringList);
  }

  Future<void> loadJsonData() async {
    // Load JSON data from the external file
    String jsonData = await rootBundle.loadString('assets/tenzi.json');

    // Parse JSON and convert it into a List of items
    setState(() {
      itemList = json.decode(jsonData).cast<Map<String, dynamic>>();
    });
  }

  void _iconButtonPressed(index) {
    setState(() {
      if (favouritesList.contains(index)) {
        favouritesList.remove(index);
      } else {
        favouritesList.add(index);
      }
      savefavourites();
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
      drawer: AppDrawer(
        favouritesList: favouritesList,
        itemList: itemList,
        iconButtonPressed: _iconButtonPressed,
      ),
      body: ListView.builder(
        itemCount: itemList!.length,
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
                _iconButtonPressed(index);
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
                    favouritesList: favouritesList,
                    itemList: itemList,
                    iconButtonPressed: _iconButtonPressed,
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
