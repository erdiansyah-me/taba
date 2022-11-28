import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taba/presentation/pages/auth_page/bloc/auth_cubit.dart';
import 'package:taba/presentation/pages/auth_page/login_page.dart';
import 'package:taba/presentation/pages/main_page/main_page.dart';

import '../../../utils/style_config.dart';
import '../../provider/preferences_provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register_page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

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
                Theme.of(context).backgroundColor,
                Theme.of(context).primaryColor,
              ],
            ],
            center: Alignment.centerRight,
            stops: const [
              0.2,
              0.8,
            ],
            radius: 1.8.r,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h,),
                Image.asset(
                  'assets/images/logo.png',
                  height: 180.h,
                ),
                SizedBox(height: 12.h,),
                Text(
                  'DAFTAR',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: Form(
                    key: _registerFormKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 24.w,
                                    right: 8.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    cursorColor:
                                        Theme.of(context).backgroundColor,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'mohon masukkan nama pengguna';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'nama pengguna',
                                      hintStyle: TextStyle(
                                        fontFamily: 'opensans',
                                        color: Theme.of(context).secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
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
                                        color: Theme.of(context).secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
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
                                        color: Theme.of(context).secondaryHeaderColor,
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
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 24.w,
                                    right: 8.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: TextFormField(
                                    obscureText: isObscureConfirmPassword,
                                    controller: _confirmPasswordController,
                                    cursorColor:
                                        Theme.of(context).backgroundColor,
                                    validator: (value) {
                                      var pass = _passwordController.text;
                                      var compare = value!.compareTo(pass);
                                      if (compare != 0) {
                                        return 'harus sama dengan kata sandi';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'konfirmasi kata sandi',
                                      hintStyle: TextStyle(
                                        fontFamily: 'opensans',
                                        color: Theme.of(context).secondaryHeaderColor,
                                      ),
                                      border: InputBorder.none,
                                      suffixIcon: isObscureConfirmPassword
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isObscureConfirmPassword =
                                                      false;
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
                                                  isObscureConfirmPassword =
                                                      true;
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
                              ),
                            ],
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
                                const TextSpan(text: 'Sudah Punya Akun? '),
                                TextSpan(
                                  text: 'Masuk Disini',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.lightBlue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ElevatedButton(
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                
                                context.read<AuthCubit>().registerUser(
                                      _usernameController.text,
                                      _emailController.text,
                                      _confirmPasswordController.text,
                                    );
                                if (state is AuthLoading) {
                                  const Center(child: CircularProgressIndicator());
                                }
                                if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Register Berhasil')),
                                  );
                                  Navigator.pushReplacementNamed(context, MainPage.routeName);
                                } else if (state is AuthError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Register Gagal: ${state.message}')),
                                  );
                                }
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //       content: Text('Register Berhasil')));
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
                              'Daftar',
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
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
