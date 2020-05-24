// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ArtistDao _artistDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `artist` (`id` TEXT, `name` TEXT, `popularity` INTEGER, `type` TEXT, `followers` INTEGER, `imageUrl` TEXT, `imageWidth` INTEGER, `imageHeight` INTEGER, PRIMARY KEY (`id`))');
        await database
            .execute('CREATE INDEX `index_artist_name` ON `artist` (`name`)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  ArtistDao get artistDao {
    return _artistDaoInstance ??= _$ArtistDao(database, changeListener);
  }
}

class _$ArtistDao extends ArtistDao {
  _$ArtistDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _artistEntityInsertionAdapter = InsertionAdapter(
            database,
            'artist',
            (ArtistEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'popularity': item.popularity,
                  'type': item.type,
                  'followers': item.followers,
                  'imageUrl': item.imageUrl,
                  'imageWidth': item.imageWidth,
                  'imageHeight': item.imageHeight
                },
            changeListener),
        _artistEntityUpdateAdapter = UpdateAdapter(
            database,
            'artist',
            ['id'],
            (ArtistEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'popularity': item.popularity,
                  'type': item.type,
                  'followers': item.followers,
                  'imageUrl': item.imageUrl,
                  'imageWidth': item.imageWidth,
                  'imageHeight': item.imageHeight
                },
            changeListener),
        _artistEntityDeletionAdapter = DeletionAdapter(
            database,
            'artist',
            ['id'],
            (ArtistEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'popularity': item.popularity,
                  'type': item.type,
                  'followers': item.followers,
                  'imageUrl': item.imageUrl,
                  'imageWidth': item.imageWidth,
                  'imageHeight': item.imageHeight
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _artistMapper = (Map<String, dynamic> row) => ArtistEntity(
      row['id'] as String,
      row['name'] as String,
      row['popularity'] as int,
      row['type'] as String,
      row['followers'] as int,
      row['imageUrl'] as String,
      row['imageWidth'] as int,
      row['imageHeight'] as int);

  final InsertionAdapter<ArtistEntity> _artistEntityInsertionAdapter;

  final UpdateAdapter<ArtistEntity> _artistEntityUpdateAdapter;

  final DeletionAdapter<ArtistEntity> _artistEntityDeletionAdapter;

  @override
  Future<ArtistEntity> findArtistById(String id) async {
    return _queryAdapter.query('SELECT * FROM Artist WHERE id = ?',
        arguments: <dynamic>[id], mapper: _artistMapper);
  }

  @override
  Future<List<ArtistEntity>> findAllArtists() async {
    return _queryAdapter.queryList('SELECT * FROM Artist',
        mapper: _artistMapper);
  }

  @override
  Future<List<ArtistEntity>> findAllArtistsWith(int limit, int offset) async {
    return _queryAdapter.queryList('SELECT * FROM Artist LIMIT ? OFFSET ?',
        arguments: <dynamic>[limit, offset], mapper: _artistMapper);
  }

  @override
  Stream<List<ArtistEntity>> findAllArtistsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Artist',
        tableName: 'artist', mapper: _artistMapper);
  }

  @override
  Future<void> insertArtist(ArtistEntity artist) async {
    await _artistEntityInsertionAdapter.insert(
        artist, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> insertArtists(List<ArtistEntity> artists) async {
    await _artistEntityInsertionAdapter.insertList(
        artists, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateArtist(ArtistEntity artist) async {
    await _artistEntityUpdateAdapter.update(
        artist, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> updateArtists(List<ArtistEntity> artists) async {
    await _artistEntityUpdateAdapter.updateList(
        artists, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<void> deleteArtist(ArtistEntity artist) async {
    await _artistEntityDeletionAdapter.delete(artist);
  }

  @override
  Future<void> deleteArtists(List<ArtistEntity> artists) async {
    await _artistEntityDeletionAdapter.deleteList(artists);
  }
}
