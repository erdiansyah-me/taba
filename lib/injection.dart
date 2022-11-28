import 'package:get_it/get_it.dart';
import 'package:taba/data/datasources/remote_data_sources.dart';
import 'package:taba/data/repositories/data_repository_impl.dart';
import 'package:taba/data/repositories/user_repository_impl.dart';
import 'package:taba/domain/repositories/data_repository.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/domain/usecases/auth_user.dart';
import 'package:taba/domain/usecases/edit_email_user.dart';
import 'package:taba/domain/usecases/edit_password_user.dart';
import 'package:taba/domain/usecases/get_list_gempa.dart';
import 'package:taba/domain/usecases/get_user_data.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/bloc/auth_cubit.dart';
import 'package:taba/presentation/pages/maps_page/maps_cubit.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => UserDataCubit(locator()));
  locator.registerFactory(() => MapsCubit(locator()));

  //usecase
  locator.registerLazySingleton(() => AuthUser(locator()));
  locator.registerLazySingleton(() => GetUserData(locator()));
  locator.registerLazySingleton(() => EditEmailUser(locator()));
  locator.registerLazySingleton(() => EditPasswordUser(locator()));
  locator.registerLazySingleton(() => GetListGempa(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  locator.registerLazySingleton<DataRepository>(() => DataRepositoryImpl(remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: locator()));

  //client
  locator.registerLazySingleton<http.Client>(() => http.Client());
}
