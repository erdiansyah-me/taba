import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/other_page/profile_page/profile_page.dart';

import '../../../utils/style_config.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lainnya'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w,),
                child: InkWell(
                  hoverColor: Theme.of(context).backgroundColor,
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName);
                  },
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
                        // CachedNetworkImage(
                        //   imageUrl: '',
                        //   imageBuilder: (context, imageProvider) =>
                        //       CircleAvatar(
                        //     backgroundImage: imageProvider,
                        //   ),
                        //   errorWidget: (context, url, error) => Image.asset(
                        //   'assets/icons/plester.png',
                        //   height: 60.h,
                        // ),
                        // ),
                        Image.asset(
                          'assets/icons/plester.png',
                          height: 60.h,
                        ),
                        Expanded(
                          child: Column(children: [
                            Text(
                              'Nama Pengguna',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'opensans',
                                fontWeight: FontWeight.w900,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              'emailpengguna@mail.com',
                              textAlign: TextAlign.center,
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
                ),
              ),
              SizedBox(height: 24.h,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
                child: Column(
                  children: [
                    _othersItem(
                      Icons.settings,
                      'Pengaturan',
                      (() {
                        //TODO: ontap
                      })
                    ),
                    Divider(thickness: 0.5.h,),
                    _othersItem(
                      Icons.feedback,
                      'Kirim Feedback',
                      (() {
                        //TODO: ontap
                      })
                    ),
                    Divider(thickness: 0.5.h,),
                    _othersItem(
                      Icons.star,
                      'Credits',
                      (() {
                        //TODO: ontap
                      })
                    ),
                    Divider(thickness: 0.5.h,),
                    _othersItem(
                      Icons.logout,
                      'Logout',
                      (() {
                        //TODO: ontap
                      })
                    ),
                  ],
                ),
              )
            ],
          ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h,),
        child: Row(
          children: [
            Icon(icon, size: 32.w,color: title == 'Logout'?
                    Colors.red
                    : ColorSystem.mediumGrey,),
            SizedBox(width: 8.w,),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'opensans',
                  color: title == 'Logout'?
                    Colors.red
                    : ColorSystem.mediumGrey,
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
