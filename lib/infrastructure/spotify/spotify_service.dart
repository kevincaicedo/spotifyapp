import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spotifyapp/config/constant.dart';
import 'package:spotifyapp/utils/http_client.dart';

abstract class SpotifyApiServiceAbstract {
  Future<HttpResponse> getArtists(int limit, int offset);
  Future<HttpResponse> getAlbums(String id, int limit, int offset);
}

class SpotifyPaths {
  static const SEARCH = "search";
  static const ALBUMS = "albums";
  static const ARTISTS = "artists";
}

class SpotifyService implements SpotifyApiServiceAbstract {
  static const USER_POST = "/test/users";
  final HttpClient client;

  SpotifyService({@required this.client}) {
    _addIntercetorClient(this.client);
  }

  @override
  Future<HttpResponse<Map<String, dynamic>>> getArtists(
      int limit, int offset) async {
    final request = await client.get(
        "${SpotifyPaths.SEARCH}?q=all&type=artist&limit=$limit&offset=$offset");

    final response = HttpResponse<Map<String, dynamic>>();

    if (request is DioError) {
      response.errorType = request.type;
      response.statusCode = request.response?.statusCode;
      response.errorMessage = request.message;
      return response;
    }

    if (request is Response) {
      response.data = request.data;
      response.statusCode = request.statusCode;
      response.statusMessage = request.statusMessage;
    }
    return response;
  }

  void _addIntercetorClient(HttpClient client) {
    client.http.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      options.headers['Authorization'] = "Bearer ${Constants.SPOTIFY_TOKEN}";
      options.path = "${Constants.API_VERSION}/${options.path}";
      return options; //continue
    }, onResponse: (Response response) async {
      return response; // continue
    }, onError: (DioError e) async {
      return e; // continue
    }));
  }

  @override
  Future<HttpResponse<Map<String, dynamic>>> getAlbums(
      String id, int limit, int offset) async {
    final request = await client
        .get("${SpotifyPaths.ARTISTS}/$id/${SpotifyPaths.ALBUMS}?limit=$limit");

    final response = HttpResponse<Map<String, dynamic>>();

    if (request is DioError) {
      response.errorType = request.type;
      response.statusCode = request.response?.statusCode;
      response.errorMessage = request.message;
      return response;
    }

    if (request is Response) {
      response.data = request.data;
      response.statusCode = request.statusCode;
      response.statusMessage = request.statusMessage;
    }
    return response;
  }
}
