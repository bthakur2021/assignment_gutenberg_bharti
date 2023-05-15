import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_color.dart';

class ThemeUtils {
  static final ThemeUtils instance = ThemeUtils();

  late ThemeMode _themeMode;

  // Parent Theme Data Related Properties
  late Brightness brightness;
  late Color scaffoldBackgroundColor;
  late Color backgroundColor;
  late Color cardColor;
  late Color dialogBackgroundColor;
  late Color textHeadingColor;
  late Color textSubHeadingColor;
  late Color textColorTitle;
  late Color textColorSubTitle;
  late Color textFieldColor;
  late Color textFieldBorderColor;

  // Child Color Theme Data Related Properties
  Color primaryColor = AppColor.primaryLight;
  late Color shadowColor;
  late Color bottomAppBarColor;
  late Color focusColor;
  late Color hoverColor;
  late Color highlightColor;
  late Color splashColor;
  late Color disabledColor;
  late Color buttonColor;
  late Color sliderActiveColor;
  late Color sliderInActiveColor;
  late Color popupBackgroundColor;
  late Color selectionTileColor;
  late Color dialogBackground;

  // Common Theme Data Related Properties
  late Color dividerColor;
  late Color hintColor;
  late Color errorColor;

  ButtonStyle? elevatedButtonThemeDataMain;

  SwitchThemeData? switchThemeData;

  TextStyle ts = const TextStyle();

  FloatingActionButtonThemeData? floatingActionButtonThemeData;

  void initialize(ThemeMode themeMode) {
    _themeMode = themeMode;
    _setParentThemeData();
    _setCommonThemeData();
  }

  void _setParentThemeData() {
    switch (_themeMode) {
      case ThemeMode.system:
        if (SchedulerBinding.instance.window.platformBrightness == Brightness.light) {
          continue light;
        }
        continue dark;
      light:
      case ThemeMode.light:
        brightness = Brightness.light;
        scaffoldBackgroundColor = scaffoldBackground;
        backgroundColor = scaffoldBackground;
        cardColor = AppColor.whiteColor;
        dialogBackgroundColor = scaffoldBackground;
        textFieldColor = AppColor.textFieldColorLight;
        textFieldBorderColor = AppColor.textFieldBorderColorLight;

        textHeadingColor = AppColor.textHeadingLightTheme;
        textSubHeadingColor = AppColor.textSubHeadingLightTheme;
        textColorTitle = AppColor.textTitleLightTheme;
        textColorSubTitle = AppColor.textSubTitleLightTheme;

        disabledColor = AppColor.themeColorGreyLight;
        _setChildColorThemeDataValues(AppColor.primaryLight);

        popupBackgroundColor = AppColor.popupBackgroundLight;
        selectionTileColor = AppColor.selectionTileColorLight;
        dialogBackground = AppColor.dialogBackgroundLight;

        switchThemeData = _switchThemeData(
          trackColor: Colors.grey.withOpacity(0.5),
          thumbColor: Colors.white,
        );
        dividerColor = AppColor.dividerColorLight;
        hintColor = AppColor.dividerColorLight;
        break;
      dark:
      case ThemeMode.dark:
        brightness = Brightness.dark;
        scaffoldBackgroundColor = scaffoldBackground;
        backgroundColor = scaffoldBackground;
        cardColor = AppColor.cardBackgroundDark;
        dialogBackgroundColor = scaffoldBackground;
        textFieldColor = AppColor.textFieldColorDark;
        textFieldBorderColor = AppColor.textFieldBorderColorDark;

        textHeadingColor = AppColor.textHeadingDarkTheme;
        textSubHeadingColor = AppColor.textSubHeadingDarkTheme;
        textColorTitle = AppColor.textTitleDarkTheme;
        textColorSubTitle = AppColor.textSubTitleDarkTheme;

        disabledColor = AppColor.themeColorGreyMedium;
        _setChildColorThemeDataValues(AppColor.primaryDark);

        popupBackgroundColor = AppColor.popupBackgroundDark;
        selectionTileColor = AppColor.selectionTileColorDark;
        dialogBackground = AppColor.dialogBackgroundDark;

        switchThemeData = _switchThemeData(
          trackColor: Colors.white.withOpacity(0.7),
          thumbColor: Colors.white,
        );
        dividerColor = AppColor.dividerColorDark;
        hintColor = AppColor.dividerColorDark;
        break;
    }

    ts = GoogleFonts.montserrat(color: textColorDefault);
  }

  void _setChildColorThemeDataValues(Color setThemeColor) {
    primaryColor = setThemeColor;
    shadowColor = setThemeColor.withOpacity(0.5);
    bottomAppBarColor = setThemeColor;
    focusColor = setThemeColor;
    hoverColor = setThemeColor.withOpacity(0.1);
    highlightColor = setThemeColor.withOpacity(0.3);
    splashColor = setThemeColor.withOpacity(0.2);
    buttonColor = setThemeColor;
    sliderActiveColor = setThemeColor;
    sliderInActiveColor = setThemeColor;
  }

  void _setCommonThemeData() {
    errorColor = AppColor.errorRed;
    elevatedButtonThemeDataMain = _elevatedButtonStyleMain();
    floatingActionButtonThemeData = const FloatingActionButtonThemeData();
  }

  ButtonStyle _elevatedButtonStyleMain() {
    return ButtonStyle(
      foregroundColor: MaterialStatePropertyExtension.resolveWithColor(
        defaultColor: textColorTextTitle,
        disableColor: AppColor.whiteColor,
      ),
      backgroundColor: MaterialStatePropertyExtension.resolveWithColor(
        defaultColor: buttonActiveColor,
        disableColor: disabledColor,
      ),
      overlayColor: MaterialStatePropertyExtension.resolveWithColor(
        defaultColor: buttonRippleColor,
        disableColor: AppColor.whiteColor,
      ),
      textStyle: MaterialStateProperty.all(ts.extTsTitle16Regular),
      elevation: MaterialStateProperty.all(0.0),
      shape: MaterialStateProperty.all(_outlinedBorderButton()),
    );
  }

  SwitchThemeData _switchThemeData({
    required Color trackColor,
    required Color thumbColor,
  }) {
    return SwitchThemeData(
      trackColor: MaterialStateProperty.all(trackColor),
      thumbColor: MaterialStateProperty.all(thumbColor),
    );
  }

  OutlinedBorder _outlinedBorderButton({double radius = 8.0}) => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      );

  static ThemeMode getThemeFromString(String name) {
    final themeName = 'ThemeMode.$name';
    return ThemeMode.values.firstWhere(
      (themeEnum) => themeEnum.toString() == themeName,
      orElse: () => ThemeMode.system,
    );
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get headlineLarge => copyWith(fontSize: 48, fontWeight: FontWeight.w600, color: ThemeUtils.instance.textHeadingColor);
  TextStyle get headlineMedium => copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: ThemeUtils.instance.textSubHeadingColor);
  TextStyle get headlineSmall => copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: ThemeUtils.instance.textSubHeadingColor);

  TextStyle get titleLarge => copyWith(fontSize: 20, fontWeight: FontWeight.w400, color: ThemeUtils.instance.textColorTitle);
  TextStyle get titleMedium => copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: ThemeUtils.instance.textColorTitle);
  TextStyle get titleSmall => copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ThemeUtils.instance.textColorTitle);

  TextStyle get labelMedium => copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: ThemeUtils.instance.textColorSubTitle);
  TextStyle get bodySmall => copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: ThemeUtils.instance.textColorSubTitle);

  TextStyle get subText => copyWith(color: ThemeUtils.instance.textColorDefault.withOpacity(0.5));

  TextStyle get extTs40 => copyWith(fontSize: 40);

  TextStyle get extTs36 => copyWith(fontSize: 36);

  TextStyle get extTs32 => copyWith(fontSize: 32);

  TextStyle get extTs24 => copyWith(fontSize: 24);

  TextStyle get extTs20 => copyWith(fontSize: 20);

  TextStyle get extTs18 => copyWith(fontSize: 18);

  TextStyle get extTs16 => copyWith(fontSize: 16);

  TextStyle get extTs14 => copyWith(fontSize: 14);

  TextStyle get extTs12 => copyWith(fontSize: 12);

  TextStyle get extTs11 => copyWith(fontSize: 11);

  TextStyle get extTs10 => copyWith(fontSize: 10);

  TextStyle get extTs9 => copyWith(fontSize: 9);

  TextStyle get extTs8 => copyWith(fontSize: 8);

  TextStyle get weightBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get weightMedium600 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get weightMedium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get weightRegular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get weightLight => copyWith(fontWeight: FontWeight.w300);

  TextStyle get colorTextTitle => copyWith(color: ThemeUtils.instance.textColorTextTitle);

  TextStyle get colorTsThemeBlack => copyWith(color: ThemeUtils.instance.themeColorBlack);

  TextStyle get colorThemeViolet => copyWith(color: ThemeUtils.instance.themeColorViolet);

  TextStyle get extColorDefault => copyWith(color: ThemeUtils.instance.textColorDefault);

  TextStyle get color15 => copyWith(color: color?.withOpacity(0.15));

  TextStyle get color25 => copyWith(color: color?.withOpacity(0.25));

  TextStyle get color50 => copyWith(color: color?.withOpacity(0.50));

  TextStyle get color75 => copyWith(color: color?.withOpacity(0.75));

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get height22 => copyWith(height: 22 / (fontSize ?? 22));

  TextStyle get height24 => copyWith(height: 24 / (fontSize ?? 24));

  TextStyle get height40 => copyWith(height: 40 / (fontSize ?? 40));

  TextStyle get extColorTextTitle => copyWith(color: AppColor.textTitle);

  TextStyle get extTsTitle16Regular => extTs16.weightRegular.extColorDefault;

  TextStyle get extTsTitle16Medium => extTs16.weightMedium.extColorDefault;
}

extension ThemeUtilsExtension on ThemeUtils {
  bool get isDark => brightness == Brightness.dark;

  Color get themePrimaryActiveColor => isDark ? AppColor.backgroundLight : AppColor.backgroundDark;

  Color get scaffoldBackground => isDark ? AppColor.backgroundDark : AppColor.backgroundLight;

  Color get themeColorDefault => isDark ? Colors.white : AppColor.themeColorBlack;

  Color get textColorDefault => isDark ? Colors.white : AppColor.themeColorBlack;

  Color get textColorTextTitle => isDark ? Colors.white : AppColor.themeColorBlack;

  Color get themeColorBlack => isDark ? AppColor.themeColorBlack : AppColor.themeColorBlack;

  Color get themeColorViolet => isDark ? darkModeWhiteColor : AppColor.themeColorViolet;

  Color get bottomActiveColor => isDark ? AppColor.whiteColor : AppColor.themeColorViolet;

  Color get bottomInActiveColor => isDark ? darkModeWhiteColor : AppColor.themeColorBlack;

  Color get darkModeWhiteColor => AppColor.whiteColor.withOpacity(0.7);

  Color get buttonActiveColor => isDark ? AppColor.primaryLight.withOpacity(0.8) : AppColor.primaryLight;
  Color get buttonRippleColor => isDark ? AppColor.primaryLight : AppColor.primaryLight.withOpacity(0.8);

  BoxDecoration get cardForegroundDecoration => BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.5) : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      );

  OutlineInputBorder get inputFieldDecoration => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: textFieldBorderColor,
      width: 0.5,
    ),
  );

  OutlineInputBorder get inputFieldFocusDecoration => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: primaryColor),
  );

  OutlineInputBorder get inputFieldErrorDecoration => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColor.errorRed),
  );

  InputDecoration inputDecorationMain({required bool isError}) {
    final border = isError ? inputFieldErrorDecoration : inputFieldDecoration;

    return InputDecoration(
      labelStyle: ts.titleMedium.copyWith(color: textColorDefault),
      hintStyle: ts.labelMedium.copyWith(color: AppColor.themeColorGreyLight),
      enabledBorder: border,
      focusedBorder: inputFieldFocusDecoration,
      errorBorder: border,
      contentPadding: const EdgeInsets.all(16.0),
      isDense: true,
      fillColor: AppColor.themeColorGreyMedium,
    );
  }
}

extension EnumAppThemeExtension on ThemeMode {
  String get name => toString().split('.').last;

  ThemeMode get opposite => this == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => this == ThemeMode.dark;
}

class MaterialStatePropertyExtension {
  static const interactiveStatesDefault = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  static const interactiveStatesDisable = <MaterialState>{
    MaterialState.disabled,
  };

  static Color _getColor(
    Set<MaterialState> states, {
    required Color defaultColor,
    required Color disableColor,
    Color? pressedColor,
  }) {
    if (states.any(interactiveStatesDefault.contains)) {
      return pressedColor ?? defaultColor;
    } else if (states.any(interactiveStatesDisable.contains)) {
      return disableColor;
    }
    return defaultColor;
  }

  static MaterialStateProperty<Color?>? resolveWithColor({
    required Color defaultColor,
    required Color disableColor,
    Color? pressedColor,
  }) =>
      MaterialStateProperty.resolveWith(
        (states) => _getColor(
          states,
          defaultColor: defaultColor,
          disableColor: disableColor,
          pressedColor: pressedColor,
        ),
      );
}
