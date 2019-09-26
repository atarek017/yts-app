import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yts/src/core/models/movieModel.dart';

class SuggestionMoviesListProvider with ChangeNotifier {
  List<MovieMode> _sugestMoviesList = [];

  List<MovieMode> get getSugestMoviesList => _sugestMoviesList;

  int _id;
  int x = 0;

  int get id => _id;

  set id(int val) {
    _id = val;
    notifyListeners();
  }

//suggestion movie fetching
  Future<void> suggestionMovies() async {
    _sugestMoviesList = [];
    x++;
    if (x <= 1) {
      final String url =
          "https://yts.lt/api/v2/movie_suggestions.json?movie_id=" +
              _id.toString();
      await http.get(url).then((response) {
        var res = json.decode(response.body);
        print(res['data']['movies'][1]);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _sugestMoviesList.add(MovieMode.fromJson(res['data']['movies'][i]));

        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });
      notifyListeners();
    }
  }
}
