import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabaThemes {
  static final darkTheme = ThemeData(
    primaryColor: ColorSystem.primaryDark,
    fontFamily: 'opensans',
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorSystem.primaryDark,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorSystem.primaryDark,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.sp,
        fontFamily: 'opensans',
        fontWeight: FontWeight.w900,
      ),
    ),
    focusColor: ColorSystem.backgroundLight,
    backgroundColor: ColorSystem.backgroundDark,
    cardColor: ColorSystem.darkGrey,
    unselectedWidgetColor: ColorSystem.mediumGrey,
    dialogBackgroundColor: ColorSystem.primaryDark,
    dividerColor: ColorSystem.mediumGrey,
    highlightColor: ColorSystem.lightGrey.withOpacity(0.5),
    indicatorColor: ColorSystem.backgroundLight,
  );
  static final lightTheme = ThemeData(
    primaryColor: ColorSystem.primary,
    fontFamily: 'opensans',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorSystem.backgroundLight,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontFamily: 'opensans',
        fontWeight: FontWeight.w900,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorSystem.primaryLight,
      )
    ),
    focusColor: ColorSystem.backgroundDark,
    backgroundColor: ColorSystem.backgroundLight,
    cardColor: ColorSystem.backgroundLight,
    unselectedWidgetColor: ColorSystem.mediumGrey,
    dialogBackgroundColor: ColorSystem.primaryLight,
    dividerColor: ColorSystem.lightGrey,
    highlightColor: ColorSystem.lightGrey.withOpacity(0.5),
    indicatorColor: ColorSystem.primary,
  );
}

class ColorSystem {
  static const primary = Color.fromRGBO(0,200,151,1.000);
  static const secondary = Color.fromRGBO(49,157,160,1.000);
  static const lightGrey = Color.fromRGBO(235,235,235,1.000);
  static const mediumGrey = Color.fromRGBO(118,118,118,1.000);
  static const darkGrey = Color.fromRGBO(63,63,63,1.000);
  static const backgroundLight = Colors.white;
  static const backgroundDark = Color.fromRGBO(18,18,18,1.000);
  static const primaryDark = Color.fromRGBO(14, 54, 45,1.000);
  static const primaryLight = Color.fromRGBO(235,247,246,1.000);
}