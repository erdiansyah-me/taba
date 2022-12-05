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
import 'package:taba/domain/usecases/get_list_p3k.dart';
import 'package:taba/domain/usecases/get_user_data.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/cubit/auth_cubit.dart';
import 'package:taba/presentation/pages/maps_page/maps_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:taba/presentation/pages/other_page/profile_page/edit_email_page/edit_email_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_password_page/edit_password_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_username_page/edit_username_cubit.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_cubit.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_search_bloc.dart';

import 'domain/usecases/edit_username_user.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => UserDataCubit(locator()));
  locator.registerFactory(() => MapsCubit(locator()));
  locator.registerFactory(() => P3kListCubit(locator()));
  locator.registerFactory(() => P3kSearchBloc(locator()));
  locator.registerFactory(() => EditEmailCubit(locator()));
  locator.registerFactory(() => EditPasswordCubit(locator()));
  locator.registerFactory(() => EditUsernameCubit(locator()));


  //usecase
  locator.registerLazySingleton(() => AuthUser(locator()));
  locator.registerLazySingleton(() => GetUserData(locator()));
  locator.registerLazySingleton(() => EditEmailUser(locator()));
  locator.registerLazySingleton(() => EditPasswordUser(locator()));
  locator.registerLazySingleton(() => EditUsernameUser(locator()));
  locator.registerLazySingleton(() => GetListGempa(locator()));
  locator.registerLazySingleton(() => GetListP3k(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  locator.registerLazySingleton<DataRepository>(() => DataRepositoryImpl(remoteDataSource: locator()));

  //datasource
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(client: locator()));

  //client
  locator.registerLazySingleton<http.Client>(() => http.Client());
}
