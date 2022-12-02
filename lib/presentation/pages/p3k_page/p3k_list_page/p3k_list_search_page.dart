import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_cubit.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_list_page/p3k_list_search_bloc.dart';
import 'package:taba/presentation/widget/grid_card_item.dart';
import 'package:taba/utils/style_config.dart';

import 'p3k_detail_page.dart';

class P3kListSearchPage extends StatefulWidget {
  static const routeName = '/p3klist_page/search';

  const P3kListSearchPage({super.key});

  @override
  State<P3kListSearchPage> createState() => _P3kListSearchPageState();
}

class _P3kListSearchPageState extends State<P3kListSearchPage> {
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
            title: const Text('Pencarian P3K'),
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
                            context
                                .read<P3kSearchBloc>()
                                .add(OnQueryChanged(value));
                          },
                          decoration: InputDecoration(
                            hintText: 'Pencarian',
                            hintStyle: TextStyle(
                              fontFamily: 'opensans',
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).splashColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                BlocBuilder<P3kSearchBloc, P3kSearchState>(
                  builder: (context, state) {
                    if (state is P3kSearchInitial) {
                      return const Expanded(
                        child: Center(
                          child: Text('Silahkan Cari Artikel \nmengenai P3K yang anda inginkan', textAlign: TextAlign.center,),
                        ),
                      );
                    } else if (state is P3kSearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is P3kSearchLoaded) {
                      return Expanded(
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
                      );
                    } else if (state is P3kSearchError) {
                      return Expanded(
                        child: Center(
                          child: Text(state.message),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          )),
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
