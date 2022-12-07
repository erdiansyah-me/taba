
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';
import '../../../../../utils/is_success_args.dart';
import '../../../../../utils/style_config.dart';
import '../../../../bloc/user_data_cubit.dart';
import '../../../../provider/preferences_provider.dart';
import '../is_success_page.dart';
import 'edit_username_cubit.dart';
import 'package:flutter/cupertino.dart';

class EditUsernamePage extends StatefulWidget {
  static const routeName = '/profile_page/edit_username_page';

  const EditUsernamePage({super.key});

  @override
  State<EditUsernamePage> createState() => _EditUsernamePageState();
}

class _EditUsernamePageState extends State<EditUsernamePage> {

  final _editUsernameFormKey = GlobalKey<FormState>();
  final _newUsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              if (Provider
                  .of<PreferencesProvider>(context)
                  .isDarkTheme) ...[
                Theme
                    .of(context)
                    .backgroundColor,
                Theme
                    .of(context)
                    .backgroundColor,
              ] else
                ...[
                  Theme
                      .of(context)
                      .primaryColor,
                  Theme
                      .of(context)
                      .backgroundColor,
                ],
            ],
            center: Alignment.bottomLeft,
            stops: const [
              0.0,
              0.9,
            ],
            radius: 1.5.r,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme
                      .of(context)
                      .focusColor,
                )),
            title: const Text('Ubah Nama Pengguna'),
            centerTitle: false,
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserDataSuccess) {
                var user = state.result;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (user.photoURL == null) ...[
                              Icon(
                                Icons.person,
                                size: 80.w,
                                color: Theme
                                    .of(context)
                                    .focusColor,
                              )
                            ] else
                              ...[
                                CachedNetworkImage(
                                  imageUrl: user.photoURL!,
                                  width: 60.w,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        backgroundImage: imageProvider,
                                        backgroundColor: Colors.transparent,
                                      ),
                                ),
                              ],
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              user.displayName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'opensans',
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: BlocListener<EditUsernameCubit, EditUsernameState>(
                        listener: (context, state) {
                          if (state is EditUsernameSuccess) {
                            Navigator.pushNamed(
                              context,
                              IsSuccessPage.routeName,
                              arguments: IsSuccessArgs(
                                isSuccess: true,
                                konteks: 'Nama pengguna',
                                navigateTo: ProfilePage.routeName,
                              ),
                            );
                          } else if (state is EditUsernameError) {
                            Navigator.pushNamed(
                              context,
                              IsSuccessPage.routeName,
                              arguments: IsSuccessArgs(
                                isSuccess: false,
                                konteks: 'Nama pengguna',
                                navigateTo: ProfilePage.routeName,
                                message: state.message,
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<EditUsernameCubit, EditUsernameState>(
                          builder: (context, state) {
                            return Form(
                              key: _editUsernameFormKey,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme
                                            .of(context)
                                            .cardColor
                                            .withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 24.h, horizontal: 12.w),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 24.w,
                                              right: 8.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme
                                                  .of(context)
                                                  .dividerColor,
                                              borderRadius:
                                              BorderRadius.circular(25.r),
                                            ),
                                            child: TextFormField(
                                              controller: _newUsernameController,
                                              cursorColor: Theme
                                                  .of(context)
                                                  .backgroundColor,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'mohon masukkan nama pengguna';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'nama pengguna baru',
                                                hintStyle: TextStyle(
                                                  fontFamily: 'opensans',
                                                  color: Theme
                                                      .of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left: 24.w,
                                              right: 8.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Theme
                                                  .of(context)
                                                  .dividerColor,
                                              borderRadius:
                                              BorderRadius.circular(25.r),
                                            ),
                                            child: TextFormField(
                                              controller: _passwordController,
                                              obscureText: isObscurePassword,
                                              cursorColor: Theme
                                                  .of(context)
                                                  .backgroundColor,
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
                                                  color: Theme
                                                      .of(context)
                                                      .secondaryHeaderColor,
                                                ),
                                                border: InputBorder.none,
                                                suffixIcon: isObscurePassword
                                                    ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isObscurePassword =
                                                      false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.visibility_off,
                                                    color: ColorSystem
                                                        .secondary,
                                                  ),
                                                )
                                                    : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isObscurePassword =
                                                      true;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.visibility,
                                                    color: ColorSystem
                                                        .secondary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty
                                                .resolveWith((states) =>
                                            ColorSystem.error),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) =>
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.r),
                                                )),
                                          ),
                                          child: Text(
                                            'Batal',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: 'opensans',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_editUsernameFormKey
                                                .currentState!
                                                .validate()) {
                                              context
                                                  .read<EditUsernameCubit>()
                                                  .editUsername(
                                                  _newUsernameController.text,
                                                  _passwordController.text);
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty
                                                .resolveWith((states) =>
                                            ColorSystem.secondary),
                                            shape: MaterialStateProperty
                                                .resolveWith((states) =>
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      25.r),
                                                )),
                                          ),
                                          child: Text(
                                            'Ubah',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: 'opensans',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is UserDataError) {
                return Center(
                  child: Text('Error: ${state.message}'),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

