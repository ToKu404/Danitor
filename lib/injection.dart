import 'package:danitor/data/data_sources/danitor_datasource.dart';
import 'package:danitor/data/repositories/danitor_repository_impl.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:danitor/domain/usecases/detail_animal_usecase.dart';
import 'package:danitor/domain/usecases/detail_location_usecase.dart';
import 'package:danitor/domain/usecases/detection_usecase.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:danitor/presentations/providers/detail_provider_notifier.dart';
import 'package:danitor/presentations/providers/detection_result_helper.dart';
import 'package:danitor/presentations/providers/get_info_location_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'presentations/providers/select_location_handler.dart';
import 'presentations/providers/target_image_notifier.dart';

final locator = GetIt.instance;

void init() {
  // DS
  locator.registerLazySingleton<DanitorDataSource>(
      () => DanitorDatasourceImpl(client: locator()));

  // Repository
  locator.registerLazySingleton<DanitorRepository>(
      () => DanitorRepositoryImpl(danitorDataSource: locator()));

  // Usecase
  locator.registerLazySingleton(() => DetectionUsecase(repository: locator()));
  locator.registerLazySingleton(
      () => DetailLocationUsecase(danitorRepository: locator()));
  locator.registerLazySingleton(
      () => DetailAnimalUsecase(danitorRepository: locator()));

  // provider
  locator.registerFactory(() => DanitorNotifier(detectionUsecase: locator()));
  locator.registerFactory(() => GetInfoLocationNotifier(usecase: locator()));
  locator.registerFactory(
      () => DetailProviderNotifier(detailAnimalUsecase: locator()));
  locator.registerFactory(() => DetectionResultHelper());
  locator.registerFactory(() => SelectLocationHandler());
  locator.registerFactory(() => TargetImageNotifier());

  // external
  locator.registerLazySingleton(() => http.Client());
}
