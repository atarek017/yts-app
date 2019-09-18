import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/core/providers/ActionMoviesProvider.dart';

import 'package:yts/src/widgets/movie_widget.dart';

class ActionMoviesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewMoviesListState();
  }
}

class _NewMoviesListState extends State<ActionMoviesList> {
  final ScrollController moviesListController = ScrollController();

  @override
  void initState() {
    super.initState();
    // fetch more movies when the list reaches its end
    moviesListController.addListener(() {
      if (moviesListController.position.pixels >=
          moviesListController.position.maxScrollExtent)
        setState(() {
          Provider.of<ActionMoviesListProvider>(context).fetchNowMovies();
        });
    });
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActionMoviesListProvider>(context);

    return FutureBuilder(
        future: provider.fetchNowMovies(),
        builder: (context, snapShot) {
          return ListView.builder(
              controller: moviesListController,
              itemCount: provider.getMoviesList.length,
              itemBuilder: (context, index) {
                return MovieWidget(provider.getMoviesList[index]);
              });
        });
  }
}
