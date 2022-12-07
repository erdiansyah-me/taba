import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taba/utils/is_success_args.dart';

import '../../../provider/preferences_provider.dart';

class IsSuccessPage extends StatefulWidget {
  static const routeName = '/profile_page/is_success';
  final IsSuccessArgs isSuccessArgs;

  const IsSuccessPage({super.key, required this.isSuccessArgs});

  @override
  State<IsSuccessPage> createState() => _IsSuccessPageState();
}

class _IsSuccessPageState extends State<IsSuccessPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.popUntil(
            context, ModalRoute.withName(widget.isSuccessArgs.navigateTo));
      },
    );
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
                Theme.of(context).primaryColor,
                Theme.of(context).backgroundColor,
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () =>
                  ModalRoute.withName(widget.isSuccessArgs.navigateTo),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.isSuccessArgs.isSuccess) ...[
                SizedBox(
                  height: 40.h,
                ),
                Image.asset(
                  'assets/images/is_success.png',
                  height: 100.h,
                  width: 100.w,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  '${widget.isSuccessArgs.konteks} Berhasil diubah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).focusColor,
                  ),
                )
              ] else ...[
                SizedBox(
                  height: 40.h,
                ),
                Image.asset(
                  'assets/images/is_unsuccess.png',
                  height: 100.h,
                  width: 100.w,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  '${widget.isSuccessArgs.konteks} gagal diubah',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'opensans',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                if (widget.isSuccessArgs.message != null) ...[
                  Text(
                    'Error : ${widget.isSuccessArgs.message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).focusColor,
                    ),
                  )
                ],
              ],
              SizedBox(
                height: 12.h,
              ),
              Text(
                'Mohon tunggu, \nanda akan dikembalikan \nke halaman pengguna',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).focusColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
