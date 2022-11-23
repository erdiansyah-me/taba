import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taba/utils/style_config.dart';
import '../preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;



  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;


  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  /*get darkTheme => ThemeData(
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
        color: Colors.white,
        fontSize: 24.sp,
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
  );*/
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color secondaryColor = Color(0xFF6B38FB);
  static const Color darkPrimaryColor = Color(0xFF000000);
  static const Color darkSecondaryColor = Color(0xff64ffda);

  get darkTheme => ThemeData (
    colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: darkPrimaryColor,
      onPrimary: Colors.black,
      secondary: darkSecondaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: secondaryColor,
        textStyle: const TextStyle(),
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.all(
            Radius.circular(0),
          ),
        ),
      ),
    ),
  );
  get lightTheme => ThemeData(
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


  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }


  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }


}
