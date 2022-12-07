import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taba/firebase_options.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/auth.dart';
import 'package:taba/presentation/pages/auth_page/cubit/auth_cubit.dart';
import 'package:taba/presentation/pages/auth_page/login_page.dart';
import 'package:taba/presentation/pages/auth_page/register_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';
import 'package:taba/presentation/pages/maps_page/maps_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_email_page/edit_email_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_email_page/edit_email_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_password_page/edit_password_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_password_page/edit_password_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_username_page/edit_username_cubit.dart';
import 'package:taba/presentation/pages/other_page/profile_page/edit_username_page/edit_username_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/is_success_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';
import 'package:taba/presentation/pages/detail_page/detail_page.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_cubit.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_page.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_search_bloc.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_search_page.dart';
import 'package:taba/presentation/pages/settings_page/settings_page.dart';
import 'package:taba/utils/is_success_args.dart';
import 'package:taba/injection.dart' as di;

import 'utils/preferences/preferences_helper.dart';
import 'presentation/provider/preferences_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  await di.locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UserDataCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<MapsCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<P3kListCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<P3kSearchBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EditEmailCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EditPasswordCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<EditUsernameCubit>(),
          ),
        ],
        child:
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: provider.themeData,
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            home: const Auth(),
            routes: {
              Auth.routeName: (context) => const Auth(),
              LoginPage.routeName: (context) => const LoginPage(),
              MainPage.routeName: (context) => const MainPage(),
              SettingsPage.routeName: (context) => const SettingsPage(),
              ProfilePage.routeName: (context) => const ProfilePage(),
              P3kListPage.routeName: (context) => const P3kListPage(),
              RegisterPage.routeName: (context) => const RegisterPage(),
              P3kListSearchPage.routeName: (context) =>
                  const P3kListSearchPage(),
              DetailPage.routeName: (context) => DetailPage(
                    urlDetail:
                        ModalRoute.of(context)?.settings.arguments as String,
                  ),
              EditPasswordPage.routeName: (context) => const EditPasswordPage(),
              EditEmailPage.routeName: (context) => const EditEmailPage(),
              EditUsernamePage.routeName: (context) => const EditUsernamePage(),
              IsSuccessPage.routeName: (context) => IsSuccessPage(
                isSuccessArgs: ModalRoute.of(context)?.settings.arguments as IsSuccessArgs
              ),
            },
          );
        }));
  }
}
