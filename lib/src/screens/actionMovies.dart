import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/core/providers/newMoviesListProvider.dart';

import 'package:yts/src/widgets/movie_widget.dart';

import 'detailsPage.dart';

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
//     fetch more movies when the list reaches its end

    moviesListController.addListener(() {
      if (moviesListController.position.pixels >=
          moviesListController.position.maxScrollExtent) {
        setState(() {
          Provider.of<NewMoviesListProvider>(context).isLoadingAction = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewMoviesListProvider>(context);

    return FutureBuilder(
        future: provider.fetchActionMovies(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
          if (snapShot.data != null && snapShot.data) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: provider.geActionMoviesList.length,
                mainAxisSpacing: 4,
                crossAxisSpacing: 10,
                padding: EdgeInsets.only(left: 10, right: 10),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index == 0 ? 2 : 3),
                itemBuilder: (context, index) {
                  return index == 0
                      ? CircleAvatar(
                          backgroundImage: AssetImage("assets/icon.png"),
                        )
                      : InkWell(
                          onTap: () {
                            provider.moveSelected(
                                provider.geActionMoviesList[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage()),
                            );
                          },
                          child:
                              MovieWidget(provider.geActionMoviesList[index]),
                        );
                });
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    moviesListController.dispose();
    super.dispose();
  }
}
