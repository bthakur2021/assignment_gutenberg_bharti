import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/assets.gen.dart';

class AppBarWidget extends HookConsumerWidget implements PreferredSizeWidget {
  AppBarWidget({
    required this.title,
    this.height = 72,
    this.icons = const <AppbarIcon>[],
    this.centerTitle = false,
    this.bottom,
    this.elevation = 0.0,
    this.color,
    this.isProfileIconVisible = true,
    this.popWithResult,
    Key? key,
  }) : super(key: key);

  final String title;
  final double height;
  final List<AppbarIcon> icons;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? color;
  final bool isProfileIconVisible;
  final dynamic popWithResult;

  @override
  Size get preferredSize => Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));

  late TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    textTheme = Theme.of(context).textTheme;

    return AppBar(
      leading: _leadingIcon(context),
      toolbarHeight: height,
      key: key,
      title: Text(
        title,
        style: textTheme.headlineMedium,
      ),
      elevation: elevation,
      actions: _actions(),
      centerTitle: centerTitle,
      bottom: bottom,
      backgroundColor: color,
    );
  }

  Widget? _leadingIcon(BuildContext context) {
    return ModalRoute.of(context)?.canPop ?? false
        ? IconButton(
            icon: Assets.icon.back.svg(),
            onPressed: () {
              Navigator.maybePop(context, popWithResult);
            },
          )
        : null;
  }

  List<Widget> _actions() {
    final newIcons = List<Widget>.from(icons);

    return newIcons
        .map(
          (icon) => Padding(
            padding: EdgeInsets.only(right: icon == newIcons.last ? 8 : 0),
            child: icon,
          ),
        )
        .toList();
  }
}

class AppbarIcon extends IconButton {
  AppbarIcon({
    required IconData iconData,
    VoidCallback? onPressed,
    Key? key,
  }) : super(
          icon: Icon(
            iconData,
          ),
          constraints: BoxConstraints.tight(
            const Size.square(
              40.0,
            ),
          ),
          onPressed: onPressed,
          splashRadius: 20.0,
          key: key,
        );

  static Widget getAppbarActionWidget({
    required AssetGenImage icon,
    VoidCallback? onPressed,
    EdgeInsets padding = const EdgeInsets.all(8.0),
  }) {
    return InkWell(
      onTap: onPressed,
      customBorder: const CircleBorder(),
      child: Container(
        padding: padding,
        constraints: BoxConstraints.tight(
          const Size.square(
            56.0,
          ),
        ),
        child: icon.image(),
      ),
    );
  }
}
