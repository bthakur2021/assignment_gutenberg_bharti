import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme_utils.dart';
import 'app_color.dart';
import 'constant.dart';

class AppStyle {
  static TextStyle titleTextRegular = const TextStyle();
  static TextStyle titleTextRegular12 = titleTextRegular.extTs12;
  static TextStyle titleTextRegular16 = titleTextRegular.extTs16.height22;
  static TextStyle titleTextRegular16a = titleTextRegular.extTs16.height22;
  static TextStyle titleTextRegular20 = titleTextRegular.extTs20;
  static TextStyle dashboardHeading = titleTextRegular.extTs32.weightBold;

  static TextStyle titleTextHeading = GoogleFonts.workSans().extTs36.weightBold;

  static const TextStyle regular12Text = TextStyle(
    fontSize: 12,
    fontWeight: Constant.fontWeightRegular,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 10.0,
    color: AppColor.errorRed,
  );
}
