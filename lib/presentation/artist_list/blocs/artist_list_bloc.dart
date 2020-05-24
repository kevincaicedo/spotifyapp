import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/infrastructure/artist/artist_repository.dart';
import 'package:spotifyapp/presentation/artist_list/blocs/artist_list_event.dart';
import 'package:spotifyapp/presentation/artist_list/blocs/artist_list_state.dart';
import 'package:spotifyapp/utils/resource.dart';

class ArtistListBloc extends Bloc<ArtistListEvent, ArtistListState> {
  @override
  ArtistListState get initialState => EmptyListArtists();

  static const _limitArtistList = 20;
  final ArtistRepository repository;
  ArtistListBloc({this.repository});

  List<Artist> _listArtists = [];
  List<Artist> get artistsList => _listArtists;

  @override
  Stream<ArtistListState> mapEventToState(ArtistListEvent event) async* {
    if (event is LoadArtistsEvent) yield* _mapLoadArtistsEventToState(event);
  }

  Stream<ArtistListState> _mapLoadArtistsEventToState(
      LoadArtistsEvent event) async* {
    yield LoadingArtists();
    final artists =
        await repository.getArtists(_limitArtistList, _listArtists.length);
    if (artists.status == StatusResource.OK) {
      _listArtists.addAll(artists.data);
      yield _listArtists.length <= 0 ? EmptyListArtists() : ArtistsLoaded();
    } else
      yield ArtistsLoadError(message: artists.message.text);
  }

  @override
  Future<void> close() {
    _listArtists.clear();
    return super.close();
  }
}
