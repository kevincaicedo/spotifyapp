import 'package:flutter/material.dart';
import 'package:spotifyapp/presentation/app/app.dart';
import 'service_locator.dart' as service_locator;

void main() {
  service_locator.init();
  runApp(SpotifyApp());
}
