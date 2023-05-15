import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/margin.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';
import 'appbar_widget.dart';
import 'button_widget.dart';

class NoItemsScreen extends HookConsumerWidget {
  const NoItemsScreen({
    required this.appBarTitle,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    this.image,
    this.icons = const <AppbarIcon>[],
    this.onPressed,
    this.hasEndDrawer = false,
    this.buttonWidth = 250,
    this.sizeType = NoItemsSizeType.common,
    this.isBigTitle = false,
    Key? key,
  }) : super(key: key);

  final String appBarTitle;
  final List<AppbarIcon> icons;
  final Widget? image;
  final String title;
  final String subtitle;
  final String buttonTitle;
  final VoidCallback? onPressed;
  final bool hasEndDrawer;
  final double buttonWidth;
  final NoItemsSizeType sizeType;
  final bool isBigTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final theme = ref.watch<ThemeProvider>(themeProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: appBarTitle,
        icons: icons,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null) ...[
                  image!,
                  sizeType.verticalMargin,
                ],
                sizeType.verticalMargin,
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: sizeType.titleStyle(theme.ts),
                ),
                sizeType.verticalMargin,
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: theme.ts.extTs16.weightRegular.color75,
                ),
                sizeType.verticalMargin,
                ButtonWidget(
                  title: buttonTitle,
                  width: buttonWidth,
                  avoidOnPressLock: true,
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum NoItemsSizeType { big, common }

extension on NoItemsSizeType {
  SizedBox get verticalMargin {
    switch (this) {
      case NoItemsSizeType.big:
        return Margin.vertical16;
      case NoItemsSizeType.common:
        return Margin.vertical8;
    }
  }

  TextStyle titleStyle(TextStyle style) {
    switch (this) {
      case NoItemsSizeType.big:
        return style.extTs20.weightBold;
      case NoItemsSizeType.common:
        return style.extTs16.weightBold;
    }
  }
}
