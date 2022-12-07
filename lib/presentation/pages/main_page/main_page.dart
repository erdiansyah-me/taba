import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/presentation/pages/auth_page/cubit/auth_cubit.dart';
import 'package:taba/presentation/pages/home_page/home_page.dart';
import 'package:taba/presentation/pages/maps_page/maps_page.dart';
import 'package:taba/presentation/pages/other_page/other_page.dart';
import 'package:taba/presentation/pages/p3k_page/p3k_page.dart';
import 'package:taba/utils/style_config.dart';
import 'package:flutter/cupertino.dart';
class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  final List<Widget> _listPages = [
    const HomePage(),
    const P3kPage(),
    const MapsPage(),
    const OtherPage(),
  ];
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {},
        child: Scaffold(
          body: _listPages[_bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedFontSize: 12.sp,
            unselectedItemColor: ColorSystem.mediumGrey,
            selectedItemColor: Theme.of(context).focusColor,
            selectedLabelStyle: TextStyle(
                fontFamily: 'opensans', color: Theme.of(context).focusColor),
            currentIndex: _bottomNavIndex,
            onTap: _onBottomNavTapped,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home_outlined,
                  color: ColorSystem.mediumGrey,
                ),
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                label: 'Utama',
                activeIcon: _activeIcon(Icons.home),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.medical_services_outlined,
                  color: ColorSystem.mediumGrey,
                ),
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                label: 'P3K',
                activeIcon: _activeIcon(Icons.medical_services),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.map_outlined,
                  color: ColorSystem.mediumGrey,
                ),
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                label: 'Maps',
                activeIcon: _activeIcon(Icons.map),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.more_horiz,
                  color: ColorSystem.mediumGrey,
                ),
                backgroundColor: Theme.of(context).dialogBackgroundColor,
                label: 'Lainnya',
                activeIcon: _activeIcon(Icons.more_horiz),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activeIcon(
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: ColorSystem.primary,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.h,
        ),
        child: Icon(
          icon,
          color: ColorSystem.backgroundLight,
        ),
      ),
    );
  }
}
