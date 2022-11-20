import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_page.dart';
import 'package:taba/presentation/widget/grid_card_item.dart';

import '../../../utils/style_config.dart';

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
            SizedBox(
              height: 8.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 12.w,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3.5/4,
                          child: GridCardItem(
                            icon: 'assets/icons/ic_p3k.png',
                            text: 'P3K dan Pentingnya P3K',
                            onTap: () {
                              //TODO: ONTAP
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 3.5/4,
                          child: GridCardItem(
                            icon: 'assets/icons/p3k_case.png',
                            text: 'Kotak P3K',
                            onTap: () {
                              //TODO: ONTAP
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  InkWell(
                    hoverColor: Theme.of(context).backgroundColor,
                    onTap: () {
                          Navigator.pushNamed(context, P3kListPage.routeName);
                        },
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/plester.png',
                              height: 60.h,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Penanganan\nPertama pada\nKorban',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'opensans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
