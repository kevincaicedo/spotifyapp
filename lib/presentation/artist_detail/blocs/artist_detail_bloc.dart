import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/album/album_model.dart';
import 'package:spotifyapp/infrastructure/artist/artist_dao.dart';
import 'package:spotifyapp/infrastructure/artist/artist_entity.dart';
import 'package:spotifyapp/infrastructure/artist/artist_repository.dart';
import 'package:spotifyapp/presentation/artist_detail/blocs/artist_detail_event.dart';
import 'package:spotifyapp/presentation/artist_detail/blocs/artist_detail_state.dart';
import 'package:spotifyapp/utils/resource.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  @override
  ArtistDetailState get initialState => EmptyListAlbums();

  List<Album> _listAlbums = [];
  List<Album> get listAlbums => _listAlbums;
  static const _limitAlbumList = 3;
  bool isArtistSaveAsFavorite = false;

  final ArtistDao artistDao;
  final ArtistRepository repository;
  ArtistDetailBloc({this.artistDao, this.repository});

  @override
  Stream<ArtistDetailState> mapEventToState(ArtistDetailEvent event) async* {
    if (event is LoadAlbumsEvent)
      yield* _mapLoadAlbumsEventToState(event);
    else if (event is ArtistAsFavoriteEvent)
      yield* _mapArtistToFavoriteEventToState(event);
    else if (event is RemoveArtistFromFavoriteEvent)
      yield* _mapRemoveArtistFromFavoriteEventToState(event);
    else if (event is VerifyFavoriteArtistEvent)
      yield* _mapVerifyFavoriteArtistEventToState(event);
  }

  Stream<ArtistDetailState> _mapLoadAlbumsEventToState(
      LoadAlbumsEvent event) async* {
    yield LoadingAlbums();
    final artists = await repository.getAlbums(
        event.id, _limitAlbumList, _listAlbums.length);
    if (artists.status == StatusResource.OK) {
      _listAlbums.addAll(artists.data);
      yield _listAlbums.length <= 0 ? EmptyListAlbums() : AlbumsLoaded();
    } else
      yield AlbumsLoadError(message: artists.message.text);
  }

  Stream<ArtistDetailState> _mapArtistToFavoriteEventToState(
      ArtistAsFavoriteEvent event) async* {
    await artistDao.insertArtist(ArtistEntity.fromArtist(event.artist));
    final savedArtist = await artistDao.findArtistById(event.artist.id);
    yield ArtistFavorite(isFavorite: savedArtist?.id == event.artist.id);
    isArtistSaveAsFavorite = savedArtist?.id == event.artist.id;
  }

  Stream<ArtistDetailState> _mapRemoveArtistFromFavoriteEventToState(
      RemoveArtistFromFavoriteEvent event) async* {
    await artistDao.deleteArtist(ArtistEntity.fromArtist(event.artist));
    yield ArtistFavorite(isFavorite: false);
    isArtistSaveAsFavorite = false;
  }

  Stream<ArtistDetailState> _mapVerifyFavoriteArtistEventToState(
      VerifyFavoriteArtistEvent event) async* {
    final artist = await artistDao.findArtistById(event.artist.id);
    yield ArtistFavorite(isFavorite: artist?.id == event.artist.id);
    isArtistSaveAsFavorite = artist?.id == event.artist.id;
  }
}
