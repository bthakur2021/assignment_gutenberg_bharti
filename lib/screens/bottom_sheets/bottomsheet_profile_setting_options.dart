import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/bottom_sheet/bottom_sheet.dart';
import '../../gen/assets.gen.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../utilities/toast_util.dart';
import 'bottom_sheet_model/bottom_options.dart';
import 'bottom_sheet_widgets/bottom_options_ui.dart';

class BottomSheetProfileSettingOptions extends StatefulHookConsumerWidget {
  const BottomSheetProfileSettingOptions({
    required this.scrollController,
    required this.parentContext,
    super.key,
  });

  final ScrollController scrollController;
  final BuildContext parentContext;

  static Future<void> show(BuildContext parentContext) async {
    return parentContext.showModalBottomSheetWidget<void>(
      isScrollControlled: true,
      maxSize: 0,
      bottomSheetChildBuilder: (context, scrollController) => BottomSheetProfileSettingOptions(
        scrollController: scrollController,
        parentContext: parentContext,
      ),
    );
  }

  @override
  ConsumerState<BottomSheetProfileSettingOptions> createState() => _BottomSheetProfileSettingOptionsState();
}

class _BottomSheetProfileSettingOptionsState extends ConsumerState<BottomSheetProfileSettingOptions> {
  late AppLocalizations localizations = AppLocalizations.of(context)!;
  late ThemeProvider theme = ref.watch(themeProvider);

  late final options = <BottomOptions>[
    BottomOptions(
      title: localizations.changeTheme,
      icon: Assets.icon.iconTheme,
      onTap: () {
        //_showToast(localizations.changeTheme);
        theme.toggleTheme(theme);
      },
      suffix: Switch(
        value: theme.isDark,
        onChanged: null,
      ),
    ),
    BottomOptions(
      title: localizations.changeLanguage,
      icon: Assets.icon.iconLanguage,
      onTap: () {
        _showToast(localizations.changeLanguage);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomOptionsUI(
      options: options,
    );
  }

  void _showToast(String msg) {
    ToastUtil.showToastRelease('$msg clicked');
  }
}
