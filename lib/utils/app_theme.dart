  import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
class AppTheme {
  static ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor:  AppColors.lightBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.mainLightColor,
      unselectedItemColor: AppColors.lightGrayColor,
      selectedLabelStyle: AppStyle.regular12MainLightColor,
      unselectedLabelStyle: AppStyle.regular12GreyColor
    ),
    cardColor: AppColors.mainLightColor,
    dividerColor: AppColors.strokeWhiteColor,
    textTheme: TextTheme(
      headlineLarge: AppStyle.semi20Black,
      headlineMedium: AppStyle.medium16Black,
      bodyLarge: AppStyle.regular14Gray,
      headlineSmall: AppStyle.semi24MainLightColor,
      labelMedium: AppStyle.medium16MainColor,
      labelSmall: AppStyle.medium18MainColor,
      labelLarge: AppStyle.semi14MainLightColor,
      bodyMedium: AppStyle.semi16MainLightColor,
      bodySmall: AppStyle.medium14Black,
      titleLarge: AppStyle.regular14MainLightColor,
      titleMedium: AppStyle.medium20Black,
      titleSmall: AppStyle.medium18Black,
    ),
  );
static final ThemeData darkTheme=ThemeData(
  scaffoldBackgroundColor: AppColors.darkBgColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBgColor,
        selectedItemColor: AppColors.mainDarkColor,
        unselectedItemColor: AppColors.lightGrayColor,
        selectedLabelStyle: AppStyle.regular12MainDarkColor,
        unselectedLabelStyle: AppStyle.regular12GreyColor
    ),
    cardColor: AppColors.mainDarkColor,
    dividerColor: AppColors.mainLightColor,
  textTheme: TextTheme(
    headlineLarge: AppStyle.semi20White,
    headlineMedium: AppStyle.medium16White,
    bodyLarge: AppStyle.regular14WhiteDarkColor,
    headlineSmall: AppStyle.semi24White,
    labelMedium: AppStyle.medium16MainDarkColor,
    labelSmall: AppStyle.medium18MainDarkColor,
    labelLarge: AppStyle.semi14MainDarkColor,
    bodyMedium: AppStyle.semi16MainDark,
    bodySmall: AppStyle.medium14White,
    titleLarge: AppStyle.regular14MainDarkColor,
    titleMedium: AppStyle.medium20WhiteDarkColor,
    titleSmall: AppStyle.medium18White,
  )
);

}
