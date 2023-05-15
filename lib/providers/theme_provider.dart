import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_color.dart';
import '../theme/theme_utils.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';
import 'utils/provider_utility.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode _themeMode;
  late ThemeData _themeData;

  void initializeThemeMetaData() {
    _themeMode = SharedPreferencesUtil.instance.getAppTheme();
    ThemeUtils.instance.initialize(_themeMode);
    _themeData = _getAppThemeModel();
  }

  Future<void> _setAppTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await SharedPreferencesUtil.instance.saveAppTheme(_themeMode);
    ThemeUtils.instance.initialize(_themeMode);

    _themeData = _getAppThemeModel();

    final statusBarColor = ThemeUtils.instance.brightness == Brightness.light ? AppColor.primaryLight : Colors.black;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: statusBarColor),
    );
    notifyListeners();
  }

  ThemeData _getAppThemeModel() {
    final themeUtilsData = ThemeUtils.instance;

    return ThemeData(
      //colorSchemeSeed: themeUtilsData.primaryColor,
      unselectedWidgetColor: themeUtilsData.disabledColor,
      indicatorColor: themeUtilsData.primaryColor,
      colorScheme: ColorScheme(
        primary: themeUtilsData.primaryColor,
        secondary: themeUtilsData.primaryColor.withOpacity(0.8),
        surface: themeUtilsData.cardColor,
        background: themeUtilsData.backgroundColor,
        error: themeUtilsData.errorColor,
        onPrimary: themeUtilsData.primaryColor.withOpacity(0.8),
        onSecondary: themeUtilsData.primaryColor.withOpacity(0.6),
        onSurface: themeUtilsData.cardColor.withOpacity(0.8),
        onBackground: themeUtilsData.backgroundColor,
        onError: themeUtilsData.errorColor,
        brightness: ThemeUtils.instance.brightness,
      ),
      dialogBackgroundColor: themeUtilsData.dialogBackgroundColor,
      shadowColor: themeUtilsData.shadowColor,
      scaffoldBackgroundColor: themeUtilsData.scaffoldBackgroundColor,
      focusColor: themeUtilsData.focusColor,
      hoverColor: themeUtilsData.hoverColor,
      highlightColor: themeUtilsData.highlightColor,
      splashColor: themeUtilsData.splashColor,
      disabledColor: themeUtilsData.disabledColor,
      dividerColor: themeUtilsData.dividerColor,
      hintColor: themeUtilsData.hintColor,
      textTheme: GoogleFonts.montserratTextTheme(TextTheme(
        headlineLarge: ts.headlineLarge,
        headlineMedium: ts.headlineMedium,
        headlineSmall: ts.headlineSmall,
        titleLarge: ts.titleLarge,
        titleMedium: ts.titleMedium,
        titleSmall: ts.titleSmall,
        labelMedium: ts.labelMedium,
        bodySmall: ts.bodySmall,
      )),
      fontFamily: GoogleFonts.montserrat().fontFamily,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: themeUtilsData.textFieldColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: themeUtilsData.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: themeUtilsData.textFieldColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: themeUtilsData.textFieldColor),
        ),
        labelStyle: ts.labelMedium,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: themeUtilsData.elevatedButtonThemeDataMain,
      ),
      floatingActionButtonTheme: themeUtilsData.floatingActionButtonThemeData,
      buttonTheme: ButtonThemeData(
        buttonColor: themeUtilsData.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: themeUtilsData.primaryColor,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(color: themeUtilsData.textColorTitle),
        ),
        centerTitle: true,
        color: themeUtilsData.backgroundColor,
        elevation: 0.4,
        iconTheme: IconThemeData(color: themeUtilsData.textColorTitle),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: themeUtilsData.backgroundColor,
      ),
      sliderTheme: SliderThemeData(
        activeTickMarkColor: themeUtilsData.sliderActiveColor,
        inactiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        disabledActiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        activeTrackColor: themeUtilsData.sliderActiveColor,
        inactiveTrackColor: themeUtilsData.sliderInActiveColor,
        disabledActiveTrackColor: themeUtilsData.sliderActiveColor.withOpacity(0.5),
        disabledInactiveTickMarkColor: themeUtilsData.sliderInActiveColor,
        thumbColor: themeUtilsData.sliderActiveColor,
        overlayColor: themeUtilsData.sliderActiveColor.withOpacity(0.5),
      ),
      cardTheme: CardTheme(
        color: themeUtilsData.cardColor,
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shadowColor: themeUtilsData.shadowColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      checkboxTheme: const CheckboxThemeData(
        shape: CircleBorder(),
      ),
      switchTheme: themeUtilsData.switchThemeData,
    );
  }

  static ThemeProvider of(WidgetRef ref) => ref.watch(themeProvider);
}

extension ThemeProviderExtension on ThemeProvider {
  bool get isDark => _themeMode == ThemeMode.dark;

  ThemeMode get appTheme => _themeMode;

  ThemeData? get themeData => _themeData;

  void changeAppThemeRead(ThemeMode changeThemeTo) => _setAppTheme(changeThemeTo);

  void toggleTheme(ThemeProvider themeProvider) => changeAppThemeRead((themeProvider._themeMode).opposite);

  void activateDarkTheme({required bool isDarkTheme}) => changeAppThemeRead(isDarkTheme ? ThemeMode.dark : ThemeMode.light);

  TextStyle get ts => ThemeUtils.instance.ts;

  TextStyle? get tsTextSmall => themeData?.textTheme.titleSmall;

  Color get primaryColor => ThemeUtils.instance.primaryColor;

  Color get themeColorViolet => ThemeUtils.instance.themeColorViolet;

  Color get scaffoldBackground => ThemeUtils.instance.scaffoldBackground;

  Color get textColor => ThemeUtils.instance.textColorDefault;

  Color get actionIconColor => ThemeUtils.instance.themeColorViolet;

  Color getBottomSheetActionColor(bool isSelected) => isSelected ? ThemeUtils.instance.bottomActiveColor : ThemeUtils.instance.bottomInActiveColor;

  Color get iconColor => ThemeUtils.instance.textColorDefault;

  Color? get popupBackground => ThemeUtils.instance.popupBackgroundColor;

  Color? get selectionTileColor => ThemeUtils.instance.selectionTileColor;

  Color? get textFieldColor => ThemeUtils.instance.textFieldColor;

  Color? get textFieldBorderColor => ThemeUtils.instance.textFieldBorderColor;

  Color? get cardColor => ThemeUtils.instance.cardColor;

  Color get themeColorDefault => ThemeUtils.instance.themeColorDefault;

  Color get textColorTextTitle => ThemeUtils.instance.textColorTextTitle;

  Color? get dialogBackground => ThemeUtils.instance.dialogBackground;

  ButtonStyle? get buttonMain => ThemeUtils.instance.elevatedButtonThemeDataMain;

  BoxDecoration get cardForegroundDecoration => ThemeUtils.instance.cardForegroundDecoration;
}
