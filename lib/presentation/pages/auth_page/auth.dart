import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taba/presentation/pages/auth_page/login_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';

class Auth extends StatelessWidget {
  static const routeName = '/auth';
  const Auth({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
  
}