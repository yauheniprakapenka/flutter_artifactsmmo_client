import 'package:data/data.dart';
import 'package:dio/src/dio.dart';
import 'package:domain/domain.dart';
import 'package:get/instance_manager.dart';

void setupDi() {
  Get.put<DioClient>(DioClient());
  final Dio dio = Get.find<DioClient>().dio;

  Get.put<MyCharactersRemoteProvider>(
    MyCharactersRemoteProvider(dio: dio),
  );

  Get.put<MyCharacterRepository>(
    MyCharacterRepositoryImpl(remoteDataSource: Get.find<MyCharactersRemoteProvider>()),
  );
}
