import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adventureMovies.dart';
import 'animationMoviesPage.dart';
import 'newMovies.dart';
import 'actionMovies.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Column(
              children: <Widget>[
                Container(
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.orange,
                    tabs: <Widget>[
                      Tab(
                        child: Text("New", style: TextStyle(color: Colors.white)),
                      ),
                      Tab(
                        child:
                            Text("Action", style: TextStyle(color: Colors.white)),
                      ),
                      Tab(
                        child: Text("Adventure",
                            style: TextStyle(color: Colors.white)),
                      ),
                      Tab(
                        child: Text("Animation",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .87,
                  child: TabBarView(
                    children: <Widget>[
                      NewMoviesList(),
                      ActionMoviesList(),
                      AdventureMoviesList(),
                      AnimationMoviesList()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
