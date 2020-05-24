import 'package:equatable/equatable.dart';

abstract class ArtistListState extends Equatable {
  const ArtistListState();

  @override
  List<Object> get props => [];
}

class LoadingArtists extends ArtistListState {
  @override
  String toString() => 'LoadingArtists {}';
}

class ArtistsLoaded extends ArtistListState {
  @override
  String toString() => 'ArtistsLoaded {}';
}

class ArtistsLoadError extends ArtistListState {
  final String message;
  const ArtistsLoadError({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ArtistsLoadError { message: $message }';
}

class EmptyListArtists extends ArtistListState {
  @override
  String toString() => 'EmptyListArtists {}';
}
