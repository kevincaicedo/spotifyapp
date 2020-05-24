import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/infrastructure/artist/artist_dao.dart';
import 'package:spotifyapp/presentation/artist_detail/screens/artist_detail_screen.dart';
import 'package:spotifyapp/presentation/artist_favorite/blocs/artist_list_bloc.dart';
import 'package:spotifyapp/presentation/artist_favorite/blocs/artist_list_event.dart';
import 'package:spotifyapp/presentation/artist_favorite/blocs/artist_list_state.dart';
import 'package:spotifyapp/service_locator.dart';
import 'package:spotifyapp/widgets/artist_card.dart';
import 'package:spotifyapp/extension/state.dart';

class FavoriteArtistsScreen extends StatelessWidget {
  const FavoriteArtistsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: false,
          title: Text("Favorite Artists",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w800)),
        ),
        body: FutureBuilder(
            future: getIt.getAsync<ArtistDao>(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return BlocProvider(
                  create: (_) =>
                      FavoriteArtistListBloc(artistDao: snapshot.data),
                  child: FavoriteArtistListView(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class FavoriteArtistListView extends StatefulWidget {
  const FavoriteArtistListView();

  @override
  FavoriteArtistListViewState createState() {
    return FavoriteArtistListViewState();
  }
}

class FavoriteArtistListViewState extends State<FavoriteArtistListView> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
    context.bloc<FavoriteArtistListBloc>().add(LoadFavoriteArtistsEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    //context.bloc<FavoriteArtistListBloc>().close();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      context.bloc<FavoriteArtistListBloc>().add(LoadFavoriteArtistsEvent());
    }
  }

  void _onTapArtist(Artist artist) async {
    final result = await Navigator.of(context).push(MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return ArtistDetailScreen(artist: artist);
        },
        fullscreenDialog: true));

    if (!result) {
      context
          .bloc<FavoriteArtistListBloc>()
          .add(RemovedFavoriteArtistsEvent(artist: artist));
    }
  }

  Widget _buildArtistItem(Artist artist) {
    return Hero(
        tag: artist.id,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onTapArtist(artist),
            child: ArtistCard(artist: artist),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteArtistListBloc, FavoriteArtistListState>(
      condition: (previousState, state) =>
          state is LoadingFavoriteArtists || state is FavoriteArtistsLoadError,
      listener: (_context, state) {
        this.showSnackBar(
            state is LoadingFavoriteArtists
                ? this.buildCircularLoading()
                : this.buildMessageError(
                    (state as FavoriteArtistsLoadError).message),
            duration: Duration(seconds: 1));
      },
      child: BlocBuilder<FavoriteArtistListBloc, FavoriteArtistListState>(
          condition: (previousState, state) =>
              state is FavoriteArtistsLoaded ||
              state is EmptyFavoriteListArtists,
          builder: (context, state) {
            if (state is FavoriteArtistsLoaded) {
              return ListView.builder(
                controller: _controller,
                itemCount:
                    context.bloc<FavoriteArtistListBloc>().artistsList.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (mcontext, position) {
                  return _buildArtistItem(context
                      .bloc<FavoriteArtistListBloc>()
                      .artistsList[position]);
                },
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: Text(
                    "There are not Artists",
                    textAlign: TextAlign.center,
                  ));
            }
          }),
    );
  }
}
