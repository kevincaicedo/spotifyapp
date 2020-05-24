import 'package:floor/floor.dart';
import 'package:spotifyapp/infrastructure/artist/artist_entity.dart';

@dao
abstract class ArtistDao {
  @Query('SELECT * FROM Artist WHERE id = :id')
  Future<ArtistEntity> findArtistById(String id);

  @Query('SELECT * FROM Artist')
  Future<List<ArtistEntity>> findAllArtists();

  @Query('SELECT * FROM Artist LIMIT :limit OFFSET :offset')
  Future<List<ArtistEntity>> findAllArtistsWith(int limit, int offset);

  @Query('SELECT * FROM Artist')
  Stream<List<ArtistEntity>> findAllArtistsAsStream();

  @insert
  Future<void> insertArtist(ArtistEntity artist);

  @insert
  Future<void> insertArtists(List<ArtistEntity> artists);

  @update
  Future<void> updateArtist(ArtistEntity artist);

  @update
  Future<void> updateArtists(List<ArtistEntity> artists);

  @delete
  Future<void> deleteArtist(ArtistEntity artist);

  @delete
  Future<void> deleteArtists(List<ArtistEntity> artists);
}
