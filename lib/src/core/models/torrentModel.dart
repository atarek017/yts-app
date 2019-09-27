class TorrentModel {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final int seeds;
  final int peers;
  final String size;
  final int size_bytes;
  final String date_uploaded;
  final int date_uploaded_unix;

  TorrentModel(
      {this.url,
      this.hash,
      this.quality,
      this.type,
      this.seeds,
      this.peers,
      this.size,
      this.size_bytes,
      this.date_uploaded,
      this.date_uploaded_unix});

  TorrentModel.fromJson(
    Map<String, dynamic> parsedJson,
  )   : this.url = parsedJson['url'],
        this.hash = parsedJson['hash'],
        this.quality = parsedJson['quality'],
        this.type = parsedJson['type'],
        this.seeds = parsedJson['seeds'],
        this.peers = parsedJson['peers'],
        this.size = parsedJson['size'],
        this.size_bytes = parsedJson['size_bytes'],
        this.date_uploaded = parsedJson['date_uploaded'],
        this.date_uploaded_unix = parsedJson['date_uploaded_unix'];
}
