import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/screens/home%20page.dart';

import 'core/providers/newMoviesListProvider.dart';
import 'core/providers/sugestionMoviesProvider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        ChangeNotifierProvider(builder: (_) => SuggestionMoviesListProvider()),

        ChangeNotifierProvider<NewMoviesListProvider>.value(
          value: NewMoviesListProvider(),
        ),

        ChangeNotifierProvider<SuggestionMoviesListProvider>.value(
          value: SuggestionMoviesListProvider(),
        )
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
