import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adventureMovies.dart';
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
        appBar: AppBar(
          title: Text("YTS App"),
        ),
        body: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: Colors.orange,
                tabs: <Widget>[
                  Tab(
                    child: Text("New",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child: Text("Action",
                        style: TextStyle(color: Colors.white)),
                  ),
                  Tab(
                    child: Text("Adventure",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * .75,
                child: TabBarView(
                  children: <Widget>[
                    NewMoviesList(),
                    ActionMoviesList(),
                    AdventureMoviesList()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
