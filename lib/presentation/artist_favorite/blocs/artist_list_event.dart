import 'package:equatable/equatable.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';

abstract class FavoriteArtistListEvent extends Equatable {
  const FavoriteArtistListEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteArtistsEvent extends FavoriteArtistListEvent {
  const LoadFavoriteArtistsEvent();

  @override
  String toString() => 'LoadFavoriteArtistsEvent {}';
}

class RemovedFavoriteArtistsEvent extends FavoriteArtistListEvent {
  final Artist artist;
  const RemovedFavoriteArtistsEvent({this.artist});

  @override
  List<Object> get props => [artist];

  @override
  String toString() => 'RemovedFavoriteArtistsEvent {}';
}
