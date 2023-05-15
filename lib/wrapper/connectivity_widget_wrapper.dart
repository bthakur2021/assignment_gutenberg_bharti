import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants/app_color.dart';
import '../constants/margin.dart';
import '../navigation/navigation_utils.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class ConnectivityWidgetWrapper extends StatefulHookConsumerWidget {
  const ConnectivityWidgetWrapper({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  @override
  ConsumerState<ConnectivityWidgetWrapper> createState() =>
      _ConnectivityWidgetWrapperState();
}

class _ConnectivityWidgetWrapperState
    extends ConsumerState<ConnectivityWidgetWrapper> {
  late ThemeProvider theme;
  late AppLocalizations localizations = AppLocalizations.of(context)!;
  InternetConnectionStatus _previousStatus = InternetConnectionStatus.connected;

  late StreamSubscription<InternetConnectionStatus> streamInternetObservable;

  @override
  void initState() {
    super.initState();
    _setObservers();
  }

  @override
  void dispose() {
    super.dispose();
    streamInternetObservable.cancel();
  }

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);

    return DividerTheme(
      data: DividerThemeData(color: theme.scaffoldBackground),
      child: widget.child,
    );
  }

  void _setObservers() {
    streamInternetObservable =
        InternetConnectionChecker.createInstance()
            .onStatusChange
            .listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (_previousStatus == InternetConnectionStatus.disconnected) {
            _hideMaterialBanner();
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (_previousStatus == InternetConnectionStatus.connected) {
            _showMaterialBanner();
          }
          break;
      }
      _previousStatus = status;
    });
  }

  void _hideMaterialBanner() {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  Future<void> _showMaterialBanner() async {
    await NavigationUtils.showInternetIssueScreen(context);

    if (mounted) {
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          padding: EdgeInsets.zero,
          content: _internetNotConnectedBanner(),
          backgroundColor: Colors.transparent,
          overflowAlignment: OverflowBarAlignment.center,
          actions: const <Widget>[
            SizedBox.shrink(),
          ],
        ),
      );
    }
  }

  Widget _internetNotConnectedBanner() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        height: 56.0,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 8, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.errorRed.withOpacity(0.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                localizations.internetNotConnected,
                style:
                    theme.ts.extTs14.weightBold.copyWith(color: Colors.white),
              ),
            ),
            Margin.horizontal11,
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.wifi_off,
                size: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
