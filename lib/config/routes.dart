import 'package:flutter/material.dart';
import 'package:spotifyapp/presentation/artist_favorite/screens/artist_favorite_screen.dart';
import 'package:spotifyapp/presentation/artist_list/screens/artist_list_screen.dart';

class Routes {
  static const main = '/';
  static const favorite = "/favorite";

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      main: (_) => const ArtistListScreen(),
      favorite: (_) => const FavoriteArtistsScreen()
    };
  }
}
