import 'package:flutter/material.dart';

import '../widgets/navigation_icon.dart';
import '../widgets/navigation_text.dart';
import 'movies list.dart';
import 'movies suggests.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageKey keyOne = PageStorageKey('pageOne');
  final PageStorageBucket storageBucket = PageStorageBucket();

  int _navigationIndex = 0;
  Widget currentPage;
  MoviesSuggests moviesSuggests;
  MoviesList moviesList;

  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    moviesList = MoviesList();
    moviesSuggests = MoviesSuggests();

    pages = [moviesList, moviesSuggests];
    currentPage = pages[_navigationIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: storageBucket,
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: NavigationIcon(Icons.list),
              title: NavigationText('movies List')),
          BottomNavigationBarItem(
              icon: NavigationIcon(Icons.star_border),
              title: NavigationText('movies Suggests')),
        ],
        currentIndex: _navigationIndex,
        onTap: (value) {
          setState(() {
            _navigationIndex = value;
            currentPage = pages[_navigationIndex];
          });
        },
      ),
    );
  }
}
