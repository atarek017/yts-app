import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/screens/home%20page.dart';

import 'core/providers/ActionMoviesProvider.dart';
import 'core/providers/AdventureMoviesProvider.dart';
import 'core/providers/newMoviesListProvider.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => NewMoviesListProvider()),
        ChangeNotifierProvider(builder: (_) => ActionMoviesListProvider()),
        ChangeNotifierProvider(builder: (_) => AdventureMoviesListProvider()),



      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
