import 'package:equatable/equatable.dart';

abstract class ArtistDetailState extends Equatable {
  const ArtistDetailState();

  @override
  List<Object> get props => [];
}

class LoadingAlbums extends ArtistDetailState {
  @override
  String toString() => 'LoadingAlbums {}';
}

class AlbumsLoaded extends ArtistDetailState {
  @override
  String toString() => 'AlbumsLoaded {}';
}

class AlbumsLoadError extends ArtistDetailState {
  final String message;
  const AlbumsLoadError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AlbumsLoadError { message: $message }';
}

class EmptyListAlbums extends ArtistDetailState {
  @override
  String toString() => 'EmptyListAlbums {}';
}

class ArtistFavorite extends ArtistDetailState {
  final bool isFavorite;
  const ArtistFavorite({this.isFavorite = false});

  @override
  List<Object> get props => [isFavorite];

  @override
  String toString() => 'ArtistFavorite { isFavorite: $isFavorite }';
}

class ArtistSaveErrorFavorite extends ArtistDetailState {
  @override
  String toString() => 'ArtistSaveErrorFavorite {}';
}
