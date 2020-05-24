import 'package:floor/floor.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';

@Entity(tableName: 'artist', indices: [
  Index(value: ['name'])
])
class ArtistEntity {
  @primaryKey
  final String id;
  final String name;
  final int popularity;
  final String type;
  final int followers;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;

  ArtistEntity(this.id, this.name, this.popularity, this.type, this.followers,
      this.imageUrl, this.imageWidth, this.imageHeight);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return '''
      ArtistEntity {
        id: $id, 
        name: $name,
        popularity: $popularity,
        type: $type,
        followers: $followers,
        imageUrl: $imageUrl,
        imageWidth: $imageWidth,
        imageHeight: $imageHeight
      }
    ''';
  }

  ArtistEntity.fromArtist(Artist artist)
      : this.id = artist.id,
        this.name = artist.name,
        this.popularity = artist.popularity,
        this.type = artist.type,
        this.followers = artist.followers,
        this.imageUrl =
            artist.images.isNotEmpty ? artist.images.first?.url : "",
        this.imageWidth =
            artist.images.isNotEmpty ? artist.images.first?.width : 0,
        this.imageHeight =
            artist.images.isNotEmpty ? artist.images.first?.height : 0;

  Artist toArtist() => Artist(
          followers: followers,
          id: id,
          name: name,
          popularity: popularity,
          type: type,
          images: [
            ArtistImage(height: imageHeight, width: imageWidth, url: imageUrl)
          ]);
}
