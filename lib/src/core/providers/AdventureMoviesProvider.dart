import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yts/src/core/models/movieModel.dart';

class AdventureMoviesListProvider with ChangeNotifier {
  List<MovieMode> _moviesList = [];
  int _pageNum = 0;

  List<MovieMode> get getMoviesList => _moviesList;

  // movie fetching
  Future<void> fetchNowMovies() async {
    _pageNum++;
    if (_pageNum <= 662) {
      final String url = "https://yts.ag/api/v2/list_movies.json?page=" +
          _pageNum.toString() +
          "&genre=Adventure";

      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          print(_pageNum.toString());

          _moviesList.add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });
      notifyListeners();
    }
  }
}
