import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ArtistImage extends Equatable {
  final int height;
  final int width;
  final String url;

  ArtistImage({this.height, this.url, this.width});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '''ArtistImage {
      height: $height,
      width: $width,
      url: $url
    }''';
  }

  ArtistImage.fromJson(Map<String, dynamic> json)
      : this.height = json['height'],
        this.width = json['width'],
        this.url = json['url'];
}

class Artist extends Equatable {
  final String id;
  final String name;
  final int popularity;
  final String type;
  final int followers;
  final List<ArtistImage> images;

  const Artist(
      {@required this.id,
      @required this.name,
      @required this.popularity,
      @required this.type,
      @required this.followers,
      @required this.images});

  @override
  List<Object> get props => [id, name, popularity, type, followers, images];

  @override
  String toString() {
    return '''Artist {
      id: $id,
      name: $name,
      popularity: $popularity,
      type: $type,
      followers: $followers,
      images: $images
    }''';
  }

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "name": this.name,
        "popularity": this.popularity,
        "type": this.type,
        "followers": this.followers,
        "images": this.images,
      };

  Artist.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.popularity = json['popularity'],
        this.type = json['type'],
        this.followers = json['followers']['total'] ?? 0,
        this.images = (json['images'] as List<dynamic>)
            .map((item) => ArtistImage.fromJson(item))
            .toList();
}

extension ParseToArtist on List<dynamic> {
  List<Artist> parseToArtists() {
    return this.map((item) => Artist.fromJson(item)).toList();
  }
}
