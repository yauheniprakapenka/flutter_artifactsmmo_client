import 'package:data/data.dart';
import 'package:dio/src/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDi() {
  getIt.registerSingleton(DioClient(token: ''));
  final Dio dio = getIt<DioClient>().dio;

  getIt.registerSingleton<MyCharactersRemoteProvider>(
    MyCharactersRemoteProvider(dio: dio),
  );

  getIt.registerSingleton<MyCharacterRepository>(
    MyCharacterRepositoryImpl(remoteDataSource: getIt<MyCharactersRemoteProvider>()),
  );
}
