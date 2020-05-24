import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotifyapp/domain/album/album_model.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/infrastructure/artist/artist_dao.dart';
import 'package:spotifyapp/presentation/artist_detail/blocs/artist_detail_bloc.dart';
import 'package:spotifyapp/presentation/artist_detail/blocs/artist_detail_event.dart';
import 'package:spotifyapp/presentation/artist_detail/blocs/artist_detail_state.dart';
import 'package:spotifyapp/service_locator.dart';
import 'package:spotifyapp/extension/state.dart';
import 'package:spotifyapp/widgets/album_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;
  const ArtistDetailScreen({@required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: FutureBuilder(
            future: getIt.getAsync<ArtistDao>(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return BlocProvider(
                  create: (_) => ArtistDetailBloc(
                      artistDao: snapshot.data, repository: getIt()),
                  child: ArtistDetail(artist: artist),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class ArtistDetail extends StatefulWidget {
  final Artist artist;
  const ArtistDetail({@required this.artist});
  @override
  _ArtistDetailState createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  @override
  void initState() {
    super.initState();
    context.bloc<ArtistDetailBloc>().add(LoadAlbumsEvent(id: widget.artist.id));
    context
        .bloc<ArtistDetailBloc>()
        .add(VerifyFavoriteArtistEvent(artist: widget.artist));
  }

  @override
  void dispose() {
    // context.bloc<ArtistDetailBloc>().close();
    super.dispose();
  }

  void _savedAsFavorite(Artist artist) {
    context.bloc<ArtistDetailBloc>().add(ArtistAsFavoriteEvent(artist: artist));
  }

  void _removeFromFavorite(Artist artist) {
    context
        .bloc<ArtistDetailBloc>()
        .add(RemoveArtistFromFavoriteEvent(artist: artist));
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context)
        .pop(context.bloc<ArtistDetailBloc>().isArtistSaveAsFavorite);
    return false;
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: NestedScrollView(
            physics: ClampingScrollPhysics(),
            headerSliverBuilder: (context, isScroll) {
              return [
                SliverAppBar(
                  actions: <Widget>[
                    BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
                        condition: (previousState, state) =>
                            state is ArtistFavorite,
                        builder: (context, state) {
                          if (state is ArtistFavorite) {
                            return IconButton(
                              icon: Icon(
                                  (state.isFavorite ?? false)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 30),
                              onPressed: () {
                                if (state.isFavorite)
                                  _removeFromFavorite(widget.artist);
                                else
                                  _savedAsFavorite(widget.artist);
                              },
                              padding: EdgeInsets.only(right: 30),
                            );
                          } else {
                            return IconButton(
                              icon: Icon(Icons.favorite_border, size: 30),
                              onPressed: () => _savedAsFavorite(widget.artist),
                              padding: EdgeInsets.only(right: 30),
                            );
                          }
                        })
                  ],
                  elevation: 0,
                  pinned: true,
                  snap: false,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  brightness: Brightness.light,
                  expandedHeight: (MediaQuery.of(context).size.height * 0.38),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                        imageUrl: widget.artist.images.isNotEmpty
                            ? widget.artist.images.first.url
                            : "",
                        filterQuality: FilterQuality.medium,
                        imageBuilder: (context, ImageProvider imageProvider) =>
                            Hero(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              tag: widget.artist.id,
                            )),
                  ),
                )
              ];
            },
            body: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Text("ALBUMS",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 22)),
                ),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: BlocListener<ArtistDetailBloc, ArtistDetailState>(
                    condition: (previousState, state) =>
                        state is LoadingAlbums ||
                        state is AlbumsLoadError ||
                        state is ArtistSaveErrorFavorite,
                    listener: (context, state) {
                      this.showSnackBar(state is LoadingAlbums
                          ? this.buildCircularLoading()
                          : this.buildMessageError(
                              (state as AlbumsLoadError).message));
                    },
                    child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
                        condition: (previousState, state) =>
                            state is AlbumsLoaded || state is EmptyListAlbums,
                        builder: (context, state) {
                          if (state is AlbumsLoaded) {
                            return ListView.builder(
                              itemCount: context
                                  .bloc<ArtistDetailBloc>()
                                  .listAlbums
                                  .length,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (mcontext, position) {
                                return _buildAlbumsList(context
                                    .bloc<ArtistDetailBloc>()
                                    .listAlbums[position]);
                              },
                            );
                          } else {
                            return Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "There are not Albums",
                                  textAlign: TextAlign.center,
                                ));
                          }
                        }),
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _buildAlbumsList(Album album) {
    return InkWell(
      onTap: () => _launchURL(album.externalUrls),
      child: AlbumView(album: album),
    );
  }
}
