import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yts/src/core/models/movieModel.dart';

class NewMoviesListProvider with ChangeNotifier {
  List<MovieMode> _newMoviesList = [];
  List<MovieMode> _adventureMoviesList = [];
  List<MovieMode> _actionMoviesList = [];
  List<MovieMode> _animationMoviesList = [];
  List<MovieMode> _sugestMoviesList = [];

  MovieMode _selectedMove;

  int _pageNumNewMovies = 0;
  int _pageNumAdventure = 0;
  int _pageNumAction = 0;
  int _pageNumAnimation = 0;
  int _idSugest;

  bool _isLoading = true;
  bool _isLoadingAction = true;
  bool _isLoadingAdventure = true;
  bool _isLoadingSugest = false;
  bool _isLoadingAnimation = true;

  List<MovieMode> get getNewMoviesList => _newMoviesList;

  List<MovieMode> get getAdventureMoviesList => _adventureMoviesList;

  List<MovieMode> get geActionMoviesList => _actionMoviesList;
  List<MovieMode> get geAnimationMoviesList => _animationMoviesList;


  List<MovieMode> get getSugestMoviesList => _sugestMoviesList;

  MovieMode get selectedMove => _selectedMove;

  moveSelected(MovieMode value) => _selectedMove = value;

  int get idSugest => _idSugest;

  set idSugest(int val) {
    _idSugest = val;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoadingAction => _isLoadingAction;

  set isLoadingAction(bool value) {
    _isLoadingAction = value;
    notifyListeners();
  }

  bool get isLoadingAdventure => _isLoadingAdventure;

  set isLoadingAdventure(bool value) {
    _isLoadingAdventure = value;
    notifyListeners();
  }

  bool get isLoadingSugest => _isLoadingSugest;

  set isLoadingSugest(bool value) {
    _isLoadingSugest = value;
    notifyListeners();
  }

  bool get isLoadingAnimation => _isLoadingAnimation;

  set isLoadingAnimation(bool value) {
    _isLoadingAnimation = value;
    notifyListeners();
  }

  //New movie fetching
  Future<bool> fetchNewMovies() async {
    if (_pageNumNewMovies <= 662 && _isLoading == true) {
      final String url =
          "https://yts.lt/api/v2/list_movies.json?sort_by=year&page= ${_pageNumNewMovies++}";

      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _newMoviesList.add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });

      _isLoading = false;
      print(_pageNumNewMovies);
      notifyListeners();
    }
    return true;
  }

  //Adventure movie fetching
  Future<bool> fetchAdventureMovies() async {
    if (_pageNumAdventure <= 660 && _isLoadingAdventure == true) {
      final String url =
          "https://yts.ag/api/v2/list_movies.json?page=${_pageNumAdventure++}" +
              "&genre=Adventure";
      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _adventureMoviesList
              .add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });
      _isLoadingAdventure = false;
      notifyListeners();
    }

    return true;
  }

  //Action movie fetching
  Future<bool> fetchActionMovies() async {
    if (_pageNumAction <= 660 && _isLoadingAction == true) {
      final String url =
          "https://yts.ag/api/v2/list_movies.json?page=${_pageNumAction++}" +
              "&genre=Action";
      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _actionMoviesList.add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });
      _isLoadingAction = false;
      notifyListeners();
    }

    return true;
  }

  //Animation movie fetching
  Future<bool> fetchAnimationMovies() async {
    if (_pageNumAnimation <= 660 && _isLoadingAnimation == true) {
      final String url =
          "https://yts.ag/api/v2/list_movies.json?page=${_pageNumAnimation++}" +
              "&genre=Animation";
      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _animationMoviesList
              .add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });
      _isLoadingAnimation = false;
      notifyListeners();
    }

    return true;
  }

  //suggestion movie fetching
  Future<bool> fetchSuggestionMovies() async {
    if (_isLoadingSugest == true && _idSugest != null) {
      final String url =
          "https://yts.lt/api/v2/movie_suggestions.json?movie_id=" +
              _idSugest.toString();
      await http.get(url).then((response) {
        var res = json.decode(response.body);
        for (int i = 0; i < res['data']['movies'].length; i++) {
          _sugestMoviesList.add(MovieMode.fromJson(res['data']['movies'][i]));
        }
      }).catchError((err) {
        print("ERROR :: " + err.toString());
      });

      _isLoadingSugest = false;
      notifyListeners();
    }
    return true;
  }
}
