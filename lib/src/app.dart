import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/screens/home%20page.dart';

import 'core/providers/moviesListProvider.dart';

class App extends StatelessWidget {
//  final MoviesListProvider moviesProvider = MoviesListProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(builder: (_) => MoviesListProvider()),


//        Provider<MoviesListProvider>.value(value:  moviesProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
