import 'package:get_it/get_it.dart';
import 'package:venteny/common/bloc/theme/theme_bloc.dart';
import 'package:venteny/core/utils/database.dart';
import 'package:venteny/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:venteny/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:venteny/src/authentication/domain/usecases/authentication_usecase.dart';
import 'package:venteny/src/home/domain/repositories/home_repository.dart';
import 'package:venteny/src/home/domain/usecases/delete_usecase.dart';
import 'package:venteny/src/home/domain/usecases/get_usecase.dart';
import 'package:venteny/src/home/domain/usecases/update_usecase.dart';
import 'package:venteny/src/home/presentation/bloc/task/create_task/create_task_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/get_taks/get_tasks_bloc.dart';
import '../../common/bloc/date/date_bloc.dart';
import '../../common/bloc/status/status_bloc.dart';
import '../../src/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/authentication/presentation/bloc/login/login_bloc.dart';
import '../../src/home/data/datasources/home_remote_data_source.dart';
import '../../src/home/data/repositories/home_repository_implementation.dart';
import '../../src/home/domain/usecases/create_usecase.dart';
import '../../src/home/domain/usecases/search_usecase.dart';
import '../../src/home/presentation/bloc/task/delete_task/delete_task_bloc.dart';
import '../../src/home/presentation/bloc/task/search/search_bloc.dart';
import '../../src/home/presentation/bloc/task/update_task/update_task_bloc.dart';
import '../config/api_services.dart';

final sl = GetIt.instance;
// ApiServices _apiServices = ApiServices();

Future<void> init() async {
  sl.registerFactory(() => ApiServices());
  sl.registerFactory(() => ThemeBloc());
  sl.registerFactory(() => DateBloc());
  sl.registerFactory(() => StatusBloc());

  //LOGIN
  sl.registerFactory(() => LoginBloc(usecase: sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()));
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSrcImpl(sl()));

  //DATABASE
  sl.registerFactory(() => DatabaseService.instance);
  sl.registerFactory(() => GetTasksBloc(usecase: sl()));
  sl.registerFactory(() => DeleteTaskBloc(usecase: sl()));
  sl.registerFactory(() => CreateTaskBloc(usecase: sl()));
  sl.registerFactory(() => UpdateTaskBloc(usecase: sl()));
  sl.registerFactory(() => SearchBloc(usecase: sl()));
  sl.registerLazySingleton(() => GetUsecase(sl()));
  sl.registerLazySingleton(() => CreateUsecase(sl()));
  sl.registerLazySingleton(() => DeleteUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUsecase(sl()));
  sl.registerLazySingleton(() => SearchUsecase(sl()));
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImplementation(sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSrcImpl(sl()));
}
