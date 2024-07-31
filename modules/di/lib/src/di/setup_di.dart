import 'package:config/config.dart';
import 'package:data/data.dart';
import 'package:dio/src/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDi() async {
  final Config config = await loadEnvironment();
  getIt.registerSingleton<Config>(config);

  getIt.registerSingleton(
    DioClient(token: getIt<Config>().token),
  );
  final Dio dio = getIt<DioClient>().dio;

  getIt.registerSingleton<MyCharactersRemoteProvider>(
    MyCharactersRemoteProvider(
      dio: dio,
      baseUrl: getIt<Config>().baseUrl,
    ),
  );

  getIt.registerSingleton<MyCharacterRepository>(
    MyCharacterRepositoryImpl(remoteDataSource: getIt<MyCharactersRemoteProvider>()),
  );
}
