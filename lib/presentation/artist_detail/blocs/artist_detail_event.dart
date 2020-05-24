import 'package:equatable/equatable.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';

abstract class ArtistDetailEvent extends Equatable {
  const ArtistDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbumsEvent extends ArtistDetailEvent {
  final String id;
  const LoadAlbumsEvent({this.id});

  @override
  String toString() => 'LoadAlbumsEvent { id: $id }';

  @override
  List<Object> get props => [id];
}

class ArtistAsFavoriteEvent extends ArtistDetailEvent {
  final Artist artist;
  const ArtistAsFavoriteEvent({this.artist});

  @override
  String toString() => 'ArtistToFavoriteEvent { artist: $artist }';

  @override
  List<Object> get props => [artist];
}

class VerifyFavoriteArtistEvent extends ArtistDetailEvent {
  final Artist artist;
  const VerifyFavoriteArtistEvent({this.artist});

  @override
  String toString() => 'VerifyFavoriteArtistEvent { artist: $artist }';

  @override
  List<Object> get props => [artist];
}

class RemoveArtistFromFavoriteEvent extends ArtistDetailEvent {
  final Artist artist;
  const RemoveArtistFromFavoriteEvent({this.artist});

  @override
  String toString() => 'RemoveArtistFromFavoriteEvent { artist: $artist }';

  @override
  List<Object> get props => [artist];
}
