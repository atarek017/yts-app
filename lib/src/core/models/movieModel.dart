import 'package:yts/src/core/models/torrentModel.dart';

class MovieMode {
  final int id;
  final String url;
  final String title;
  final int year;
  final String rating;
  final int runtime;
  final List<dynamic> genres;
  final String summary;
  final String language;
  final String medium_cover_image;
  final String yt_trailer_code;
  final List<TorrentModel> torrents;

  MovieMode(
      {this.id,
      this.url,
      this.title,
      this.year,
      this.rating,
      this.genres,
      this.language,
      this.medium_cover_image,
      this.runtime,
      this.summary,
      this.yt_trailer_code,
      this.torrents});

  MovieMode.fromJson(Map<String, dynamic> parsedJson)
      : this.id = parsedJson['id'],
        this.url = parsedJson['url'],
        this.year = parsedJson['year'],
        this.rating = parsedJson['rating'].toString(),
        this.runtime = parsedJson['runtime'],
        this.genres = parsedJson['genres'] as List<dynamic>,
        this.summary = parsedJson['summary'],
        this.language = parsedJson['language'],
        this.medium_cover_image = parsedJson['medium_cover_image'],
        this.title = parsedJson['title'],
        this.yt_trailer_code = parsedJson['yt_trailer_code'],
        this.torrents = (parsedJson['torrents'] as List<dynamic>).map( (torrentJson) => TorrentModel.fromJson(torrentJson)).toList();
}
