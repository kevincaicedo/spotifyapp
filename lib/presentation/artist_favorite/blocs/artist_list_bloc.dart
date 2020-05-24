import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/infrastructure/artist/artist_dao.dart';
import 'package:spotifyapp/presentation/artist_favorite/blocs/artist_list_event.dart';
import 'package:spotifyapp/presentation/artist_favorite/blocs/artist_list_state.dart';
import 'package:spotifyapp/utils/resource.dart';

class FavoriteArtistListBloc
    extends Bloc<FavoriteArtistListEvent, FavoriteArtistListState> {
  @override
  FavoriteArtistListState get initialState => EmptyFavoriteListArtists();

  static const _limitArtistList = 20;
  final ArtistDao artistDao;
  FavoriteArtistListBloc({this.artistDao});

  List<Artist> _listArtists = [];
  List<Artist> get artistsList => _listArtists;

  @override
  Stream<FavoriteArtistListState> mapEventToState(
      FavoriteArtistListEvent event) async* {
    if (event is LoadFavoriteArtistsEvent)
      yield* _mapLoadArtistsEventToState(event);
    else if (event is RemovedFavoriteArtistsEvent)
      yield* _mapRemovedFavoriteArtistsEventToState(event);
  }

  Stream<FavoriteArtistListState> _mapRemovedFavoriteArtistsEventToState(
      RemovedFavoriteArtistsEvent event) async* {
    // yield LoadingFavoriteArtists();
    _listArtists.removeWhere((item) => item.id == event.artist.id);
    yield FavoriteArtistsLoaded();
  }

  Stream<FavoriteArtistListState> _mapLoadArtistsEventToState(
      LoadFavoriteArtistsEvent event) async* {
    yield LoadingFavoriteArtists();
    final artists = await artistDao.findAllArtistsWith(
        _limitArtistList, _listArtists.length);
    if (artists != null) {
      _listArtists.addAll(artists.map((item) => item.toArtist()).toList());
      yield _listArtists.length <= 0
          ? EmptyFavoriteListArtists()
          : FavoriteArtistsLoaded();
    } else
      yield FavoriteArtistsLoadError(message: UnknowError().text);
  }

  @override
  Future<void> close() {
    _listArtists.clear();
    return super.close();
  }
}
