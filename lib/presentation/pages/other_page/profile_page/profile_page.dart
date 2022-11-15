import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/utils/style_config.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'Profile_Page';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).backgroundColor,
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).focusColor,
                )),
            title: const Text('Pengguna'),
            centerTitle: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: onpressed
            },
            backgroundColor: ColorSystem.secondary,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Center(
                    child: Column(
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
                          height: 100.h,
                        ),
                        SizedBox(height: 8.h,),
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.6),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
                    child: Column(
                      children: [
                        _othersItem('Ubah Email Pengguna', (() {
                          //TODO: ontap
                        })),
                        Divider(
                          thickness: 0.5.h,
                        ),
                        _othersItem('Ubah Kata Sandi', (() {
                          //TODO: ontap
                        })),
                        Divider(
                          thickness: 0.5.h,
                        ),
                        _othersItem('Reset Kata Sandi', (() {
                          //TODO: ontap
                        })),
                        Divider(
                          thickness: 0.5.h,
                        ),
                        _othersItem('Logout', (() {
                          //TODO: ontap
                        })),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _othersItem(
    String title,
    Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            if (title == 'Logout') ...[
              Icon(Icons.logout, size: 32.w, color: Colors.red),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.w,
                color: ColorSystem.mediumGrey,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
