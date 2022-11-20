import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:taba/presentation/pages/auth_page/register_page.dart';

import '../../../utils/style_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).primaryColor.withAlpha(100),
              Theme.of(context).backgroundColor,
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.h, top: 12.h),
                child: Text(
                  'Selamat ${getCurrentTime()}, Asep!',
                  style: TextStyle(
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w900,
                    fontSize: 14.sp,
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
                    fontSize: 16.sp,
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
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    color: ColorSystem.mediumGrey,
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
