// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'utilities/toast_util.dart';

class ConnectivityWidgetWrapper extends StatefulHookWidget {
  const ConnectivityWidgetWrapper({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  State<ConnectivityWidgetWrapper> createState() => _ConnectivityWidgetWrapperState();
}

class _ConnectivityWidgetWrapperState extends State<ConnectivityWidgetWrapper> with WidgetsBindingObserver {
  InternetConnectionStatus _previousStatus = InternetConnectionStatus.connected;

  late StreamSubscription<InternetConnectionStatus> streamInternetObservable;
  bool isApplicationActive = true;

  @override
  void initState() {
    super.initState();
    _setObservers();
  }

  @override
  void dispose() {
    super.dispose();
    streamInternetObservable.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _setObservers() {
    streamInternetObservable = InternetConnectionChecker().onStatusChange.listen((status) {
      if (!isApplicationActive) {
        return;
      }
      switch (status) {
        case InternetConnectionStatus.connected:
          if (_previousStatus == InternetConnectionStatus.disconnected) {
            ToastUtil.showToastRelease('Internet Connected Back');
          }
          break;
        case InternetConnectionStatus.disconnected:
          if (_previousStatus == InternetConnectionStatus.connected) {
            ToastUtil.showToastRelease('Internet Not Connected');
          }
          break;
      }
      _previousStatus = status;
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isApplicationActive = state == AppLifecycleState.resumed;
  }
}
