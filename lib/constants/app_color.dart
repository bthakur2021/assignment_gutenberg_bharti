import 'package:flutter/material.dart';

class AppColor {
  static const Color errorRed = Color(0xFFFD6F71);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color successIconColor = Color(0xFF7CFF9A);

  static Color white20Opacity = Colors.white.withOpacity(0.2);

  // Light Theme Colors
  static const Color primaryLight = themeColorViolet;
  static const Color backgroundLight = themeColorBackgroundLight;
  static const Color cardBackgroundLight = whiteColor;
  static const Color textHeadingLightTheme = primaryLight;
  static const Color textSubHeadingLightTheme = primaryLight;
  static const Color textTitleLightTheme = themeColorGreyDark;
  static const Color textSubTitleLightTheme = themeColorGreyMedium;
  static const Color textFieldColorLight = themeColorGreyLight;
  static const Color textFieldBorderColorLight = themeColorGreyMedium;
  static const Color popupBackgroundLight = whiteColor;
  static const Color selectionTileColorLight = whiteColor;
  static const Color dialogBackgroundLight = whiteColor;
  static const Color dividerColorLight = themeColorGreyLight;

  // Dark Theme Colors
  static const Color primaryDark = themeColorGreyDark;
  static const Color backgroundDark = themeColorGreyDark;
  static const Color cardBackgroundDark = Color(0xFF373440);
  static const Color textHeadingDarkTheme = whiteColor;
  static const Color textSubHeadingDarkTheme = whiteColor;
  static const Color textTitleDarkTheme = whiteColor;
  static const Color textSubTitleDarkTheme = whiteColor;
  static Color textFieldColorDark = whiteColor.withOpacity(0.05);
  static Color textFieldBorderColorDark = whiteColor.withOpacity(0.40);
  static const Color popupBackgroundDark = primaryDark;
  static const Color selectionTileColorDark = Color(0xFF292732);
  static const Color dialogBackgroundDark = Color(0xFF242748);
  static const Color dividerColorDark = themeColorGreyMedium;

  static const Color appBarColor = whiteColor;
  static const Color textTitle = Color(0xFF323B59);
  static const Color cardCvvGrey = Color(0xFFFFF5DD);

  static const Color themeColorViolet = Color(0xFF5E56E7);
  static const Color themeColorBackgroundLight = Color(0xFFF8F7FF);
  static const Color themeColorGreyLight = Color(0xFFF0F0F6);
  static const Color themeColorGreyMedium = Color(0xFFA0A0A0);
  static const Color themeColorGreyDark = Color(0xFF333333);
  static const Color themeColorBlack = themeColorGreyDark;
}
