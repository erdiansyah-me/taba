import 'package:get_it/get_it.dart';
import 'package:taba/data/repositories/user_repository_impl.dart';
import 'package:taba/domain/repositories/user_repository.dart';
import 'package:taba/domain/usecases/register_user.dart';
import 'package:taba/presentation/pages/auth_page/bloc/auth_cubit.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => AuthCubit(locator()));

  //usecase
  locator.registerLazySingleton(() => RegisterUser(locator()));

  //repository
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
