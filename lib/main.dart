import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:tenzi_za_rohoni/screens/app_drawer.dart';
import 'package:tenzi_za_rohoni/screens/details_page.dart';
import 'package:tenzi_za_rohoni/utils/colors.dart';
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
      theme: lightTheme,
      // darkTheme: darkTheme,
      home: const ClickableListScreen(),
    );
  }
}

class ClickableListScreen extends StatefulWidget {
  const ClickableListScreen({super.key});

  @override
  State<ClickableListScreen> createState() => _ClickableListScreenState();
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
  final InAppReview inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) async {
      if (_rateMyApp.shouldOpenDialog) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showRateDialog();
        });
      }
    });
    loadJsonData(); // Call the method to load JSON data
    loadFavourites();
  }

  void _showRateDialog() {
    _rateMyApp.showRateDialog(
      context,
      title: 'Unapenda Tenzi za Rohoni?',
      message: 'Tafadhali chukua muda kutupatia tathmini yako!',
      rateButton: 'KAGUA SASA',
      noButton: 'HAPANA ASANTE',
      laterButton: 'BAADAYE',
      listener: (button) {
        if (button == RateMyAppDialogButton.rate) {
          inAppReview.isAvailable().then((available) {
            if (available) {
              inAppReview.requestReview();
            }
          });
        }
        return true;
      },
      dialogStyle: const DialogStyle(),
      onDismissed: () {},
    );
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

  void iconButtonPressed(index) {
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
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ), // Show a loading indicator while loading the JSON data
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tenzi za Rohoni',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Add the search icon button to the AppBar
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SongSearchDelegate(
                  itemList: itemList!,
                  searchResults: _searchResults,
                  searchQuery: _searchQuery,
                  updateSearchResults: _updateSearchResults,
                  favouritesList: favouritesList,
                  iconButtonPressed: iconButtonPressed,
                ),
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(
        favouritesList: favouritesList,
        itemList: itemList,
        iconButtonPressed: iconButtonPressed,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.amber.withOpacity(0.05),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: itemList!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              trailing: IconButton(
                icon: Icon(
                  favouritesList.contains(index)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: favouritesList.contains(index)
                      ? Colors.red
                      : Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  iconButtonPressed(index);
                },
              ),
              title: Text(
                itemList![index]['title'],
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                itemList![index]['subtitle'],
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  (itemList![index]['song_number']).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      item: itemList![index],
                      favouritesList: favouritesList,
                      itemList: itemList,
                      iconButtonPressed: iconButtonPressed,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
