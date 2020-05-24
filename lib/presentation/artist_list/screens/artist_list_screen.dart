import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/presentation/artist_detail/screens/artist_detail_screen.dart';
import 'package:spotifyapp/presentation/artist_list/blocs/artist_list_bloc.dart';
import 'package:spotifyapp/presentation/artist_list/blocs/artist_list_event.dart';
import 'package:spotifyapp/presentation/artist_list/blocs/artist_list_state.dart';
import 'package:spotifyapp/service_locator.dart';
import 'package:spotifyapp/widgets/artist_card.dart';
import 'package:spotifyapp/extension/state.dart';

class ArtistListScreen extends StatelessWidget {
  const ArtistListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, size: 30, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushNamed('/favorite');
            },
            padding: EdgeInsets.only(right: 30),
          )
        ],
        title: Text("Artists",
            style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w900)),
      ),
      body: BlocProvider(
        create: (_) => ArtistListBloc(repository: getIt()),
        child: ArtistListView(),
      ),
    );
  }
}

class ArtistListView extends StatefulWidget {
  const ArtistListView();

  @override
  ArtistListViewState createState() {
    return ArtistListViewState();
  }
}

class ArtistListViewState extends State<ArtistListView> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
    context.bloc<ArtistListBloc>().add(LoadArtistsEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller = null;
    // context.bloc<ArtistListBloc>().close();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      context.bloc<ArtistListBloc>().add(LoadArtistsEvent());
    }
  }

  void _onTapArtist(Artist artist) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ArtistDetailScreen(artist: artist);
        },
        fullscreenDialog: true));
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
    return BlocListener<ArtistListBloc, ArtistListState>(
      condition: (previousState, state) =>
          state is LoadingArtists || state is ArtistsLoadError,
      listener: (context, state) {
        this.showSnackBar(state is LoadingArtists
            ? this.buildCircularLoading()
            : this.buildMessageError((state as ArtistsLoadError).message));
      },
      child: BlocBuilder<ArtistListBloc, ArtistListState>(
          condition: (previousState, state) =>
              state is ArtistsLoaded || state is EmptyListArtists,
          builder: (context, ArtistListState state) {
            if (state is ArtistsLoaded) {
              return ListView.builder(
                controller: _controller,
                itemCount: context.bloc<ArtistListBloc>().artistsList.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (mcontext, position) {
                  return _buildArtistItem(
                      context.bloc<ArtistListBloc>().artistsList[position]);
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
