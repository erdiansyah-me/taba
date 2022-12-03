import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taba/presentation/pages/auth_page/cubit/auth_cubit.dart';
import 'package:taba/presentation/pages/auth_page/register_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';

import '../../../utils/style_config.dart';
import '../../provider/preferences_provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  bool isObscurePassword = true;
  bool isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              if (Provider.of<PreferencesProvider>(context).isDarkTheme) ...[
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
              ] else ...[
                Theme.of(context).primaryColor,
                Theme.of(context).backgroundColor,
              ],
            ],
            center: Alignment.centerRight,
            stops: const [
              0,
              0.5,
            ],
            radius: 1.8.r,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: BlocListener<AuthCubit, AuthState>(
            listener: (BuildContext context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login Berhasil')),
                );
                Navigator.pushReplacementNamed(context, MainPage.routeName);
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Gagal: ${state.message}')),
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              if (state is AuthLoading) {
                const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 180.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'MASUK',
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).focusColor),
                  ),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: Form(
                      key: _loginFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 8.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor:
                                      Theme.of(context).backgroundColor,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'mohon masukkan email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'email',
                                    hintStyle: TextStyle(
                                      fontFamily: 'opensans',
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 24.w,
                                  right: 8.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: isObscurePassword,
                                  cursorColor:
                                      Theme.of(context).backgroundColor,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 6) {
                                      return 'kata sandi tidak boleh kurang dari 6 karakter';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'kata sandi',
                                    hintStyle: TextStyle(
                                      fontFamily: 'opensans',
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                    border: InputBorder.none,
                                    suffixIcon: isObscurePassword
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isObscurePassword = false;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.visibility_off,
                                              color: ColorSystem.secondary,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isObscurePassword = true;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.visibility,
                                              color: ColorSystem.secondary,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w400,
                                    color: ColorSystem.mediumGrey,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Belum Punya Akun? '),
                                    TextSpan(
                                      text: 'Daftar Disini',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'opensans',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, RegisterPage.routeName);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_loginFormKey.currentState!.validate()) {
                                    context.read<AuthCubit>().loginUser(
                                          _emailController.text,
                                          _passwordController.text,
                                        );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => ColorSystem.secondary),
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.r),
                                          )),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
