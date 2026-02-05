import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sams_dashboard/core/network/api_consumer.dart';
import 'package:sams_dashboard/core/network/dio_consumer.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo_impl.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(getIt<Dio>()));

  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<ApiConsumer>()),
  );
}
