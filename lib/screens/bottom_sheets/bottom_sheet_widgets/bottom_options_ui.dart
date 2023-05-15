import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../navigation/navigation_utils.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/utils/provider_utility.dart';
import '../bottom_sheet_model/bottom_options.dart';

class BottomOptionsUI extends StatefulHookConsumerWidget {
  const BottomOptionsUI({
    required this.options,
    this.scrollController,
    super.key,
  });

  final List<BottomOptions> options;
  final ScrollController? scrollController;

  @override
  ConsumerState<BottomOptionsUI> createState() => _BottomOptionsUIState();
}

class _BottomOptionsUIState extends ConsumerState<BottomOptionsUI> {
  late ThemeProvider _theme;

  @override
  Widget build(BuildContext context) {
    _theme = ref.watch(themeProvider);
    return _mainWidget();
  }

  Widget _mainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: widget.scrollController,
          itemBuilder: (context, index) {
            final e = widget.options[index];
            return ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              splashColor: _theme.themeColorDefault,
              onTap: () {
                NavigationUtils.pop(context);
                e.onTap();
              },
              //leading: Icon(e.icon, color: e.color),
              leading: e.icon.image(color: e.color ?? _theme.iconColor, width: 20, height: 20),
              title: Text(e.title, style: _theme.ts.copyWith(color: e.color)),
              trailing: e.suffix,
            );
          },
          itemCount: widget.options.length),
    );
  }
}
