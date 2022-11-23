import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:taba/presentation/bloc/user_data_cubit.dart';
import 'package:taba/presentation/pages/auth_page/register_page.dart';
import 'package:taba/presentation/provider/preferences_provider.dart';

import '../../../utils/style_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<UserDataCubit>().getUserData());
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              if (Provider.of<PreferencesProvider>(context).isDarkTheme) ...[
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
              ] else ...[
                Theme.of(context).primaryColor.withAlpha(100),
                Theme.of(context).backgroundColor,
              ],
            ],
            center: Alignment.centerLeft,
            stops: const [
              0,
              0.4,
            ],
            radius: 2.r,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (context, state) {
              if (state is UserDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserDataSuccess) {
                return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.h, top: 12.h),
                    child: Text(
                      'Selamat ${getCurrentTime()}, ${state.result.displayName}!',
                      style: TextStyle(
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w900,
                        fontSize: 16.sp,
                        color: Theme.of(context).focusColor
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'SIAP TANGGAP BENCANA!',
                      style: TextStyle(
                        fontFamily: 'opensans',
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
                    child: Image.asset('assets/images/home_pic.png'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h,),
                      child: Column(
                        children: [
                          _listItem(
                            context,
                            'assets/icons/ic_kategori.png',
                            'Kategori Bencana',
                            'Kenali beberapa kategori bencana alam yang dapat terjadi agar kita lebih waspada dan tetap tenang',
                            (() {

                            })
                          ),
                          SizedBox(height: 8.h,),
                          _listItem(
                            context,
                            'assets/icons/ic_evac.png',
                            'Evakuasi? Tetap tenang dan sesuai prosedur',
                            'Evakuasi massa yang sembarangan dan tidak teratur membuat proses evakuasi menjadi terhambat!',
                            (() {
                              
                            })
                          ),
                          SizedBox(height: 8.h,),
                          _listItem(
                            context,
                            'assets/icons/ic_important.png',
                            'Ketahui Nomor Instansi Darurat!',
                            'Pentingnya Mengetahui tentang nomor instansi darurat terdekat, agar penanganan lebih cepat!',
                            (() {
                              
                            })
                          ),
                        ],
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
            }
          ),
        ),
      ),
    );
  }

  Widget _listItem(
    BuildContext context,
    String icon,
    String title,
    String subtitle,
    Function() onTap
  ) {
    return InkWell(
      // hoverColor: Theme.of(context).backgroundColor,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: ColorSystem.backgroundDark.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 60.w,
            ),
            SizedBox(width: 8.w,),
            Expanded(
              child: Column(children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ]),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  String getCurrentTime() {
    final currentTime = DateTime.now();

    if (currentTime.hour >= 05 && currentTime.hour <= 10) {
      return 'Pagi';
    } else if (currentTime.hour >= 11 && currentTime.hour <= 14) {
      return 'Siang';
    } else if (currentTime.hour >= 15 && currentTime.hour <= 19) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }
}
