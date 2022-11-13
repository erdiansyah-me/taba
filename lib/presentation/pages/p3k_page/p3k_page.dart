import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class P3kPage extends StatelessWidget {
  const P3kPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
              child: Text(
                'Pertolongan Pertama Pada Korban',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'opensans',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/p3k_case.png', width: 100.w,height: 100.h,),
                  Text('SOON'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
