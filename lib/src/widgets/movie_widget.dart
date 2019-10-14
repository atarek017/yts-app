import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yts/src/core/models/movieModel.dart';

class MovieWidget extends StatelessWidget {
  final MovieMode movieMode;

  MovieWidget(this.movieMode);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        width: MediaQuery.of(context).size.width * .5,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
          boxShadow: [
            new BoxShadow(
              offset: Offset(0.0, 1.0),
              color: Colors.blueAccent,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 135,
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2, color: Colors.white),
                    bottom: BorderSide(width: 2, color: Colors.white),
                    right: BorderSide(width: 2, color: Colors.white),
                    left: BorderSide(width: 2, color: Colors.white),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      movieMode.medium_cover_image,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
              movieMode.title,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
              movieMode.genres.toString(),
              maxLines: 1,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(movieMode.year.toString()),
                Row(
                  children: <Widget>[
                    Text(movieMode.rating),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                    )
                  ],
                ),
                Text("720"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
