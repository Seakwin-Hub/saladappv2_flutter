import 'package:flutter/material.dart';
import 'package:saladappv2_flutter/common/theme/custom_theme.dart';
import 'package:saladappv2_flutter/util/app_constants.dart';
import 'package:saladappv2_flutter/util/style.dart';

ThemeData dark() => ThemeData(
  useMaterial3: true,
  fontFamily: AppConstants.fontFamily,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: AppColors.darkerGrey,
  textTheme: CustomThemeStyle.textThemeCustom(Colors.black),
  chipTheme: CustomThemeStyle.chipTheme(Colors.grey, Colors.white),
  appBarTheme: CustomThemeStyle.appBarTheme(),
  checkboxTheme: CustomThemeStyle.checkboxTheme(),
  bottomSheetTheme: CustomThemeStyle.bottomSheetTheme(Colors.black),
  elevatedButtonTheme: CustomThemeStyle.elevationButtonTheme(),
  outlinedButtonTheme: CustomThemeStyle.outlinedButtonTheme(
    Colors.white,
    Colors.blueAccent,
  ),
  inputDecorationTheme: CustomThemeStyle.inputDecorationTheme(
    Colors.black,
    Colors.black12,
    isDark: true,
  ),
);
