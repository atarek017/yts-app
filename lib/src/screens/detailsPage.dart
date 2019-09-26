import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/core/providers/newMoviesListProvider.dart';
import 'package:yts/src/screens/trailar.dart';
import 'package:yts/src/widgets/movie_widget.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      Future.delayed(Duration(seconds: 1), () {
        Provider.of<NewMoviesListProvider>(context).getSugestMoviesList.clear();
        Provider.of<NewMoviesListProvider>(context).idSugest =
            Provider.of<NewMoviesListProvider>(context).selectedMove.id;
        Provider.of<NewMoviesListProvider>(context).isLoadingSugest = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    NewMoviesListProvider provider =
        Provider.of<NewMoviesListProvider>(context);
    double wedght = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Center(
            child: Image.network(
              provider.selectedMove.medium_cover_image,
              height: hight * .7,
              width: wedght * .7,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: wedght,
            height: 50,
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Name :  " + provider.selectedMove.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Genre :  " + provider.selectedMove.genres.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            " Description : ",
            style: TextStyle(color: Colors.deepOrange),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            provider.selectedMove.summary,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            " Trailar : ",
            style: TextStyle(color: Colors.deepOrange),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Image.network("https://img.youtube.com/vi/" +
                    provider.selectedMove.yt_trailer_code.toString() +
                    "/0.jpg"),
                Positioned(
                  top: hight * .15,
                  right: wedght * .35,
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.black87),
                      child: IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            size: 60,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Trailar(
                                    provider.selectedMove.yt_trailer_code)));
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Sugestion moves",
              style: TextStyle(
                  color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 450,
            child: FutureBuilder(
                future: provider.fetchSuggestionMovies(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapShot) {
                  if (snapShot.data != null && snapShot.data) {
                    return ListView.builder(
                        itemCount: provider.getSugestMoviesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              provider.moveSelected(
                                  provider.getSugestMoviesList[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MovieWidget(
                                  provider.getSugestMoviesList[index]),
                            ),
                          );
                        });
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
