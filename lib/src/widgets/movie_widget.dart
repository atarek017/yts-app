import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yts/src/core/models/movieModel.dart';

class MovieWidget extends StatelessWidget {
  MovieMode movieMode;

  MovieWidget(this.movieMode);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.only(left: 5,right: 5),
      width: MediaQuery.of(context).size.width * .5,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(3),
              child: Hero(
                tag: '${movieMode.id}',
                child: Image.network(
                  movieMode.medium_cover_image,
                  height: 135,
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
    ));
  }
}
