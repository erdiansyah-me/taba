import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba/firebase_options.dart';
import 'package:taba/presentation/pages/auth_page/auth.dart';
import 'package:taba/presentation/pages/auth_page/bloc/auth_cubit.dart';
import 'package:taba/presentation/pages/auth_page/register_page.dart';
import 'package:taba/presentation/pages/home_page/home_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_page.dart';
import 'package:taba/utils/style_config.dart';
import 'package:taba/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  await di.locator.allReady();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:  (_) => di.locator<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: TabaThemes.lightTheme,
        home: const Auth(),
        initialRoute: Auth.routeName,
        routes: {
          Auth.routeName:(context) => const Auth(),
          MainPage.routeName: (context) => const MainPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          P3kListPage.routeName: (context) => const P3kListPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
        },
      ),
    );
  }
}
