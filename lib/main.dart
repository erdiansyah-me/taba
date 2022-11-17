// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taba/firebase_options.dart';
import 'package:taba/presentation/pages/home_page/home_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';
import 'package:taba/utils/style_config.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TabaThemes.lightTheme,
      home: MainPage(),
      initialRoute: MainPage.routeName,
      routes: {
        MainPage.routeName:(context) => const MainPage(),
        ProfilePage.routeName:(context) => const ProfilePage(),
      },
    );
  }
}
