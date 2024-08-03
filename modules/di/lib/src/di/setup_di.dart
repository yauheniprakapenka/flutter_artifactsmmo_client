import 'package:config/config.dart';
import 'package:data/data.dart';
import 'package:dio/src/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDi() async {
  // Config

  final Config config = await loadEnvironment();
  getIt.registerSingleton<Config>(config);

  // Clients

  getIt.registerSingleton(DioClient(token: getIt<Config>().token));
  final Dio dio = getIt<DioClient>().dio;

  // Providers

  getIt.registerSingleton<MyCharactersRemoteProvider>(
    MyCharactersRemoteProvider(dio: dio, baseUrl: getIt<Config>().baseUrl),
  );

  getIt.registerSingleton<CharactersRemoteProvider>(
    CharactersRemoteProvider(dio: dio, baseUrl: getIt<Config>().baseUrl),
  );

  getIt.registerSingleton<MapsRemoteProvider>(
    MapsRemoteProvider(dio: dio, baseUrl: getIt<Config>().baseUrl),
  );

  // Repositories

  getIt.registerSingleton<MyCharacterRepository>(
    MyCharacterRepositoryImpl(remoteDataSource: getIt<MyCharactersRemoteProvider>()),
  );

  getIt.registerSingleton<CharactersRepository>(
    CharactersRepositoryImpl(remoteDataSource: getIt<CharactersRemoteProvider>()),
  );

  getIt.registerSingleton<MapsRepository>(
    MapsRepositoryImpl(remoteDataSource: getIt<MapsRemoteProvider>()),
  );
}
