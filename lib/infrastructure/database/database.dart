import 'dart:async';
import 'package:floor/floor.dart';
import 'package:spotifyapp/infrastructure/artist/artist_dao.dart';
import 'package:spotifyapp/infrastructure/artist/artist_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ArtistEntity])
abstract class AppDatabase extends FloorDatabase {
  ArtistDao get artistDao;
}
