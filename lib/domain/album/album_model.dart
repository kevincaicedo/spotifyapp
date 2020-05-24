import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';

class Album extends Equatable {
  final String id;
  final String name;
  final String releaseDate;
  final String externalUrls;
  final List<ArtistImage> images;

  const Album(
      {@required this.id,
      @required this.name,
      @required this.releaseDate,
      @required this.externalUrls,
      @required this.images});

  @override
  List<Object> get props => [id, name, releaseDate, externalUrls, images];

  @override
  String toString() {
    return '''Album {
      id: $id,
      name: $name,
      releaseDate: $releaseDate
      externalUrls: $externalUrls,
      images: $images
    }''';
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "releaseDate": this.releaseDate,
        "externalUrls": this.externalUrls,
        "images": this.images,
      };

  Album.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.releaseDate = json['release_date'],
        this.externalUrls = json['external_urls']['spotify'],
        this.images = (json['images'] as List<dynamic>)
            .map((item) => ArtistImage.fromJson(item))
            .toList();
}

extension ParseToAlbum on List<dynamic> {
  List<Album> parseToAlbum() {
    return this.map((item) => Album.fromJson(item)).toList();
  }
}
