import 'package:equatable/equatable.dart';

abstract class ArtistListEvent extends Equatable {
  const ArtistListEvent();

  @override
  List<Object> get props => [];
}

class LoadArtistsEvent extends ArtistListEvent {
  const LoadArtistsEvent();

  @override
  String toString() => 'LoadArtistsEvent {}';
}
