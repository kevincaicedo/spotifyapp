import 'package:get_it/get_it.dart';
import 'package:spotifyapp/utils/http_client.dart';
import 'package:spotifyapp/config/constant.dart';

import 'infrastructure/artist/artist_dao.dart';
import 'infrastructure/artist/artist_repository.dart';
import 'infrastructure/database/database.dart';
import 'infrastructure/spotify/spotify_service.dart';

final getIt = GetIt.instance;

void init() {
  //Singleton for HTTP request
  getIt.registerLazySingleton<HttpClient>(
      () => HttpClient(baseUrl: Constants.BASE_URL));

  getIt.registerLazySingleton<SpotifyApiServiceAbstract>(
      () => SpotifyService(client: getIt()));
  getIt.registerLazySingleton<ArtistRepository>(
      () => ArtistRepositoryImpl(spotifyService: getIt()));

  getIt.registerLazySingletonAsync<AppDatabase>(() async =>
      await $FloorAppDatabase.databaseBuilder(Constants.DB_NAME).build());
  getIt.registerLazySingletonAsync<ArtistDao>(
      () async => (await getIt.getAsync<AppDatabase>()).artistDao);
}
