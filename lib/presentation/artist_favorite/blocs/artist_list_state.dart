import 'package:equatable/equatable.dart';

abstract class FavoriteArtistListState extends Equatable {
  const FavoriteArtistListState();

  @override
  List<Object> get props => [];
}

class LoadingFavoriteArtists extends FavoriteArtistListState {
  @override
  String toString() => 'LoadingFavoriteArtists {}';
}

class FavoriteArtistsLoaded extends FavoriteArtistListState {
  @override
  String toString() => 'FavoriteArtistsLoaded {}';
}

class FavoriteArtistsLoadError extends FavoriteArtistListState {
  final String message;
  const FavoriteArtistsLoadError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'FavoriteArtistsLoadError { message: $message }';
}

class EmptyFavoriteListArtists extends FavoriteArtistListState {
  @override
  String toString() => 'EmptyFavoriteListArtists {}';
}
