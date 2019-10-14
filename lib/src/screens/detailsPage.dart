import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yts/src/core/providers/newMoviesListProvider.dart';
import 'package:yts/src/screens/trailar.dart';
import 'package:yts/src/widgets/fade_animation.dart';
import 'package:yts/src/widgets/movie_widget.dart';
import 'package:yts/src/widgets/torrent_widget.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailsPageState();
  }
}

class _DetailsPageState extends State<DetailsPage> {
  NewMoviesListProvider provider;
  double wedght;
  double hight;
  var date;

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
    provider = Provider.of<NewMoviesListProvider>(context);
    wedght = MediaQuery.of(context).size.width;
    hight = MediaQuery.of(context).size.height;

    date =
        new DateTime.fromMicrosecondsSinceEpoch(provider.selectedMove.runtime);

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          FadeAnimation(
            1,
            image(),
          ),
          SizedBox(
            height: 5,
          ),
          FadeAnimation(
            2,
            detailsBox(),
          ),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
            3,
            Text(
              " Description : ",
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
            4,
            Text(
              provider.selectedMove.summary,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
              1,
              Text(
                " Trailar : ",
                style: TextStyle(color: Colors.deepOrange),
              )),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
            1,
            trailer(),
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
            height: 10,
          ),
          sugestionMovies(),
          SizedBox(
            height: 20,
          ),
          Text(
            " Torrent Links : ",
            style: TextStyle(color: Colors.deepOrange),
          ),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
            1,
            torrentLinks(),
          )
        ],
      ),
    );
  }

  double getHighTtourent() {
    int length = Provider.of<NewMoviesListProvider>(context)
        .selectedMove
        .torrents
        .length;

    double tourHight = length.toDouble() * 150;
    if (length >= 3) {
      tourHight = 2.5 * 150;
    }
    return tourHight;
  }

  Widget image() {
    return Center(
      child: Container(
        height: hight * .7,
        width: wedght * .7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              provider.selectedMove.medium_cover_image,
            ),
          ),
          boxShadow: [
            new BoxShadow(
              offset: Offset(0.0, -1.0),
              color: Color(0xffEDEDED),
              blurRadius: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsBox() {
    return Container(
      padding: EdgeInsets.all(5),
      width: wedght,
      height: 100,
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AutoSizeText(
            "Name  :  " + provider.selectedMove.title,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: 5,
          ),
          AutoSizeText(
            "Genre  :  " + provider.selectedMove.genres.toString(),
            maxLines: 1,
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Rating :  " + provider.selectedMove.rating.toString(),
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          Text(
            "Year     :  " + provider.selectedMove.year.toString(),
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
          Text(
            "Time    :  " +
                date.hour.toString() +
                "h : " +
                date.minute.toString() +
                " m",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget trailer() {
    return Container(
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
                          builder: (context) =>
                              Trailar(provider.selectedMove.yt_trailer_code)));
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sugestionMovies() {
    return Container(
      height: provider.getSugestMoviesList.length >= 1 ? 270 : 0,
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
                        provider
                            .moveSelected(provider.getSugestMoviesList[index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MovieWidget(provider.getSugestMoviesList[index]),
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
    );
  }

  Widget torrentLinks() {
    return Container(
      height: getHighTtourent(),
      child: ListView.builder(
        itemCount: provider.selectedMove.torrents.length,
        itemBuilder: (context, index) {
          return TorrentWidget(provider.selectedMove.torrents[index]);
        },
      ),
    );
  }
}
