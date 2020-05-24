import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spotifyapp/domain/album/album_model.dart';
import 'package:spotifyapp/domain/artist/artist_model.dart';
import 'package:spotifyapp/infrastructure/spotify/spotify_service.dart';
import 'package:spotifyapp/utils/resource.dart';

abstract class ArtistRepository {
  Future<Resource<List<Artist>>> getArtists(int limit, int offset);
  Future<Resource<List<Album>>> getAlbums(String id, int limit, int offset);
}

class ArtistRepositoryImpl implements ArtistRepository {
  final SpotifyApiServiceAbstract spotifyService;

  const ArtistRepositoryImpl({@required this.spotifyService});

  @override
  Future<Resource<List<Artist>>> getArtists(int limit, int offset) async {
    final response = await spotifyService.getArtists(limit, offset);
    final artists = Resource<List<Artist>>();

    if (response.statusCode == 200) {
      artists.data =
          (response.data["artists"]["items"] as List).parseToArtists();
      artists.status = StatusResource.OK;
      artists.message = OkMessage();
      return artists;
    }

    artists.status = StatusResource.FAIL;
    if (response.errorType == DioErrorType.CONNECT_TIMEOUT ||
        response.errorType == DioErrorType.RECEIVE_TIMEOUT) {
      artists.message = NetworkError();
    } else if (response.statusCode == 401) {
      artists.message = UnauthorizedError();
    } else
      artists.message = UnknowError();
    return artists;
  }

  @override
  Future<Resource<List<Album>>> getAlbums(
      String id, int limit, int offset) async {
    final response = await spotifyService.getAlbums(id, limit, offset);
    final artists = Resource<List<Album>>();

    if (response.statusCode == 200) {
      artists.data = (response.data["items"] as List).parseToAlbum();
      artists.status = StatusResource.OK;
      artists.message = OkMessage();
      return artists;
    }

    artists.status = StatusResource.FAIL;
    if (response.errorType == DioErrorType.CONNECT_TIMEOUT ||
        response.errorType == DioErrorType.RECEIVE_TIMEOUT) {
      artists.message = NetworkError();
    } else if (response.statusCode == 401) {
      artists.message = UnauthorizedError();
    } else
      artists.message = UnknowError();
    return artists;
  }
}
