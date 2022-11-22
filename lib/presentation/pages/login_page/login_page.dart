import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';

import '../../../utils/style_config.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'Login_Page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).backgroundColor,
              Theme.of(context).primaryColor.withAlpha(40),
            ],
          ),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png', height: 150, width: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "MASUK",
              style: TextStyle(
                fontFamily: 'opensans',
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'email',
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(top: 20),
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(40)
                      ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          //border: OutlineInputBorder(),
                          /*focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)),*/
                          hintText: "kata sandi",
                          border: OutlineInputBorder(borderSide: BorderSide.none)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w400,
                        color: ColorSystem.mediumGrey,
                      ),
                      children: [
                        const TextSpan(text: 'Tidak Punya Akun? '),
                        TextSpan(
                          text: 'Daftar Disini',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'opensans',
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, MainPage.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Color.fromRGBO(49,157,160,1.000),
                    child: SizedBox(
                      height: 40,
                      width: 130,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        splashColor: Colors.white,
                        onTap: () => {
                        Navigator.pushNamed(context, MainPage.routeName),
                      },
                        child: const Center(
                          child: Text(
                            "Masuk", style: TextStyle(fontFamily: 'open sans',fontSize: 20, color: Color.fromRGBO(235,235,235,1.000)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}