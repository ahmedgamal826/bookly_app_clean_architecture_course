import 'package:clean_architecture_course/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:clean_architecture_course/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:clean_architecture_course/Features/home/data/repos/home_repo_impl.dart';
import 'package:clean_architecture_course/core/services/api_services.dart';
import 'package:clean_architecture_course/main.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiServices>(
    ApiServices(
      Dio(),
    ),
  );

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiServices: getIt.get<ApiServices>(),
      ),
    ),
  );
}
