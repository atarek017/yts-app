import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yts/src/core/models/movieModel.dart';

class MovieWidget extends StatelessWidget {
  MovieMode movieMode;

  MovieWidget(this.movieMode);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
          child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * .7,
        height: 460,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(4),
                child: Image.network(
                  movieMode.medium_cover_image,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              movieMode.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              movieMode.genres.toString(),
              style: TextStyle(fontSize: 16),
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
      )),
    );
  }
}
