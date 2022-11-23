import 'package:get_it/get_it.dart';
import 'package:taba/data/repositories/user_repository_impl.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/domain/usecases/auth_user.dart';
import 'package:taba/domain/usecases/get_user_data.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/bloc/auth_cubit.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AuthCubit(locator()));
  locator.registerFactory(() => UserDataCubit(locator()));

  //usecase
  locator.registerLazySingleton(() => AuthUser(locator()));
  locator.registerLazySingleton(() => GetUserData(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
