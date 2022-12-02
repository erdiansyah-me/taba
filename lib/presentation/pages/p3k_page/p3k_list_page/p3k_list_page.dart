import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_detail_page.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_cubit.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_search_page.dart';
import 'package:taba/presentation/widget/grid_card_item.dart';
import 'package:taba/utils/style_config.dart';

class P3kListPage extends StatefulWidget {
  static const routeName = '/p3klist_page';

  const P3kListPage({super.key});

  @override
  State<P3kListPage> createState() => _P3kListPageState();
}

class _P3kListPageState extends State<P3kListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<P3kListCubit>().getListP3k());
  }

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
          // title: const Text('P3K dan \n Keadaan Darurat'),
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'P3K dan',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).focusColor,
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w900),
                children: <TextSpan>[
                  TextSpan(
                    text: '\nKeadaan Darurat',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ]),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, P3kListSearchPage.routeName),
              icon: Icon(
                Icons.search,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ],
        ),
        body:
            BlocBuilder<P3kListCubit, P3kListState>(builder: (context, state) {
          if (state is P3kListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is P3kListLoaded) {
            return Container(
              color: Theme.of(context).backgroundColor,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      crossAxisCount: 2,
                      children: state.result
                          .map(
                            (p3klist) => gridCardItem(
                              () => {
                                Navigator.pushNamed(
                                    context, P3kDetailPage.routeName,
                                    arguments: p3klist.linkToDetail)
                              },
                              p3klist.urlPhoto,
                              p3klist.title,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is P3kListError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget gridCardItem(
    Function() onTap,
    String imageUrl,
    String title,
  ) {
    return InkWell(
      hoverColor: Theme.of(context).backgroundColor,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
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
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, progress) {
                return Center(
                    child: CircularProgressIndicator(
                  value: progress.progress,
                ));
              },
              fit: BoxFit.cover,
            ),
            Container(
              color: ColorSystem.backgroundDark.withAlpha(100),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'opensans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
