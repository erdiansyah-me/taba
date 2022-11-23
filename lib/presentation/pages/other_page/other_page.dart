import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/auth.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';

import '../../../utils/style_config.dart';
import '../settings_page/settings_page.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserDataCubit>().getUserData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Lainnya'),
          centerTitle: false,
        ),
        body: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserDataSuccess) {
              final user = state.result;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      child: InkWell(
                        hoverColor: Theme.of(context).backgroundColor,
                        onTap: () {
                          Navigator.pushNamed(context, ProfilePage.routeName);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorSystem.backgroundDark.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (user.photoURL == null) ...[
                                Icon(
                                  Icons.person,
                                  size: 60.w,
                                  color: Theme.of(context).focusColor,
                                )
                              ] else ...[
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
                              Expanded(
                                child: Column(children: [
                                  Text(
                                    user.displayName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'opensans',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.sp,
                                      color: Theme.of(context).focusColor
                                    ),
                                  ),
                                  Text(
                                    user.email,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'opensans',
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ]),
                              ),
                              Icon(Icons.arrow_forward_ios, color: Theme.of(context).focusColor,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 24.h, horizontal: 12.w),
                      child: Column(
                        children: [
                          _othersItem(
                            Icons.settings,
                            'Pengaturan',
                            (() async {
                              Navigator.pushNamed(
                                  context, SettingsPage.routeName);
                            }),
                          ),
                          Divider(
                            thickness: 0.5.h,
                          ),
                          _othersItem(Icons.feedback, 'Kirim Feedback', (() {
                            //TODO: ontap
                          })),
                          Divider(
                            thickness: 0.5.h,
                          ),
                          _othersItem(Icons.star, 'Credits', (() {
                            //TODO: ontap
                          })),
                          Divider(
                            thickness: 0.5.h,
                          ),
                          _othersItem(Icons.logout, 'Logout', (() async {
                            await FirebaseAuth.instance.signOut();
                          })),
                        ],
                      ),
                    ),
                  ],
                ),
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
    );
  }

  Widget _othersItem(
    IconData icon,
    String title,
    Function() onTap,
  ) {
    return InkWell(
      hoverColor: ColorSystem.mediumGrey,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32.w,
              color: title == 'Logout' ? Colors.red : ColorSystem.mediumGrey,
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'opensans',
                  color:
                      title == 'Logout' ? Colors.red : ColorSystem.mediumGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
