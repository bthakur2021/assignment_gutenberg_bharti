import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../common_widgets/issue_screen.dart';
import '../common_widgets/no_items_screen.dart';
import '../gen/assets.gen.dart';
import '../screens/books/books_search_screen.dart';
import '../screens/home/home_screen.dart';
import '../utilities/extension_utils.dart';

class NavigationUtils {
  static void pop(BuildContext context) => Navigator.pop(context);

  static void moveToNoItemScreen(BuildContext context) => moveToScreen(
      context,
      NoItemsScreen(
        appBarTitle: 'No Item',
        title: 'Sorry!',
        subtitle: 'Work is under progress',
        buttonTitle: 'Close',
        onPressed: () {
          NavigationUtils.pop(context);
        },
      ));

  static void moveToStartToApp(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static void moveToHome(BuildContext context) => moveToScreen(context, const HomeScreen());

  static void moveToBookSearchScreen(BuildContext context, {required String category}) => moveToScreen(
      context,
      BooksSearchScreen(
        category: category,
      ));

  static Future<void> showInternetIssueScreen(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return _moveToScreenAsync<void>(
      context,
      IssueScreen(
        image: Assets.images.astronautNointernet.assetImage,
        title: localizations.youWentOffline,
        subtitle: localizations.youWentOfflineSupportText,
      ),
    );
  }

  static void popFullScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void _openFullscreen(BuildContext context, Widget widget) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => widget,
        fullscreenDialog: true,
      ),
    );
  }

  static void moveToScreen(
    BuildContext context,
    Widget screenToMoveOn, {
    String? name,
    bool isRemoveAllOtherScreens = false,
  }) {
    if (isRemoveAllOtherScreens) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (_) => screenToMoveOn,
            settings: RouteSettings(name: name),
          ),
          (route) => false);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (_) => screenToMoveOn,
          settings: RouteSettings(name: name ?? ''),
        ),
      );
    }
  }

  static Future<T?> _moveToScreenAsync<T>(
    BuildContext context,
    Widget screenToMoveOn, {
    String? name,
  }) {
    if (name != null) {
      return Navigator.push<T>(
        context,
        MaterialPageRoute<T>(
          builder: (context) => screenToMoveOn,
          settings: RouteSettings(name: name),
        ),
      );
    } else {
      return Navigator.push<T>(
        context,
        MaterialPageRoute<T>(
          builder: (context) => screenToMoveOn,
        ),
      );
    }
  }
}
