import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/fixture.dart';
import '../../constants/margin.dart';
import '../../gen/assets.gen.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';
import '../../utilities/print_util.dart';
import '../bottom_sheets/bottomsheet_profile_setting_options.dart';

class SettingIcon extends StatefulHookConsumerWidget {
  const SettingIcon({
    super.key,
  });

  @override
  ConsumerState<SettingIcon> createState() => _SettingIconState();
}

class _SettingIconState extends ConsumerState<SettingIcon> {
  late AppLocalizations localizations = AppLocalizations.of(context)!;
  late ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);
    return IconButton(
      onPressed: () {
        BottomSheetProfileSettingOptions.show(context);
      },
      icon: Icon(
        Icons.settings,
        size: 48,
        color: theme.textColor,
      ),
    );
  }
}
