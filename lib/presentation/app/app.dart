import 'package:flutter/material.dart';
import 'package:spotifyapp/config/constant.dart';
import 'package:spotifyapp/config/routes.dart';

class SpotifyApp extends StatelessWidget {
  const SpotifyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME_DISPLAY,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: Routes.main,
      routes: Routes.getRoute(),
    );
  }
}
