import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/widget/grid_card_item.dart';
import 'package:taba/utils/style_config.dart';

class P3kListPage extends StatelessWidget {

  static const routeName = '/p3klist_page';

  const P3kListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).focusColor,
              )),
          title: const Text('P3K'),
          centerTitle: false,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TextField(
                        cursorColor: Theme.of(context).backgroundColor,
                        onChanged: (value) {
                          //TODO: onchanged
                        },
                        decoration: InputDecoration(
                          hintText: 'Pencarian',
                          hintStyle: TextStyle(
                            fontFamily: 'opensans',
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: Theme.of(context).splashColor,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  crossAxisCount: 2,
                  children: [
                    GridCardItem(icon: 'assets/images/p3k_case.png', text: 'Sakit Gigi', onTap: (() {})),
                    GridCardItem(icon: 'assets/images/p3k_case.png', text: 'Keseleo', onTap: (() {})),
                    GridCardItem(icon: 'assets/images/p3k_case.png', text: 'Demam', onTap: (() {})),
                    GridCardItem(icon: 'assets/images/p3k_case.png', text: 'Masuk Angin', onTap: (() {})),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
