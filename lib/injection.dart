import 'package:danitor/data/data_sources/danitor_datasource.dart';
import 'package:danitor/data/repositories/danitor_repository_impl.dart';
import 'package:danitor/domain/repositories/danitor_repository.dart';
import 'package:danitor/domain/usecases/detail_animal_usecase.dart';
import 'package:danitor/domain/usecases/detail_location_usecase.dart';
import 'package:danitor/domain/usecases/detection_usecase.dart';
import 'package:danitor/domain/usecases/get_history_usecase.dart';
import 'package:danitor/domain/usecases/get_user_data_usecase.dart';
import 'package:danitor/domain/usecases/register_usecase.dart';
import 'package:danitor/core/common/auth_helper.dart';
import 'package:danitor/domain/usecases/update_location_usecase.dart';
import 'package:danitor/presentations/providers/auth_notifier.dart';
import 'package:danitor/presentations/providers/danitor_notifier.dart';
import 'package:danitor/presentations/providers/detail_provider_notifier.dart';
import 'package:danitor/presentations/providers/detection_result_helper.dart';
import 'package:danitor/presentations/providers/get_info_location_notifier.dart';
import 'package:danitor/presentations/providers/login_notifier.dart';
import 'package:danitor/presentations/providers/register_notifier.dart';
import 'package:danitor/presentations/providers/user_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'domain/usecases/is_login_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'presentations/providers/select_location_handler.dart';
import 'presentations/providers/target_image_notifier.dart';

final locator = GetIt.instance;

void init() {
  // DS
  locator.registerLazySingleton<DanitorDataSource>(
      () => DanitorDatasourceImpl(client: locator(), helper: locator()));

  // Repository
  locator.registerLazySingleton<DanitorRepository>(
      () => DanitorRepositoryImpl(danitorDataSource: locator()));

  // Usecase
  locator.registerLazySingleton(() => DetectionUsecase(repository: locator()));
  locator.registerLazySingleton(
      () => DetailLocationUsecase(danitorRepository: locator()));
  locator.registerLazySingleton(
      () => DetailAnimalUsecase(danitorRepository: locator()));
  locator.registerLazySingleton(() => RegisterUsecase(repository: locator()));
  locator.registerLazySingleton(() => LoginUsecase(repository: locator()));
  locator.registerLazySingleton(() => LogoutUsecase(repository: locator()));
  locator.registerLazySingleton(() => IsLoginUsecase(repository: locator()));
  locator.registerLazySingleton(
      () => GetUserDataUsecase(danitorRepository: locator()));
  locator.registerLazySingleton(
      () => UpdateLocationUsecase(danitorRepository: locator()));

  // provider
  locator.registerFactory(() => DanitorNotifier(detectionUsecase: locator()));
  locator.registerFactory(() => GetInfoLocationNotifier(usecase: locator()));
  locator.registerFactory(
      () => DetailProviderNotifier(detailAnimalUsecase: locator()));
  locator.registerFactory(() => DetectionResultHelper());
  locator.registerFactory(
      () => SelectLocationHandler(updateLocationUsecase: locator()));
  locator.registerFactory(() => LoginNotifier(loginUsecase: locator()));
  locator.registerFactory(() => RegisterNotifier(registerUsecase: locator()));
  locator
      .registerFactory(() => GetHistoryUsecase(danitorRepository: locator()));

  locator.registerFactory(() => TargetImageNotifier());
  locator.registerFactory(() => UserNotifier(
        getUserDataUsecase: locator(),
        getHistoryUsecase: locator()
      ));

  locator.registerFactory(
      () => AuthNotifier(isLoginUsecase: locator(), logoutUsecase: locator()));

  // external
  locator.registerLazySingleton<AuthHelper>(() => AuthHelper());
  locator.registerLazySingleton(() => http.Client());
}
