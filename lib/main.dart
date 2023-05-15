import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'utilities/lottie_cache.dart';
import 'utilities/storage/shared_preference/shared_preferences_util.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common_widgets/waiting_screen_widget.dart';
import 'connectivity_widget_wrapper.dart';
import 'providers/theme_provider.dart';
import 'providers/utils/provider_utility.dart';
import 'screens/splash/splash_screen.dart';

const appTitle = 'Frontier';

void main() {
  setupApp();
}

Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtil.initialize();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  /*if (Platform.isAndroid) {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }*/

  runApp(const ProviderScope(child: InitializerWidget()));
}

class InitializerWidget extends StatefulHookConsumerWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  late final theme = ref.watch(themeProvider);

  late final Future<void> init = _appInitialize();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme.initializeThemeMetaData();
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      if (theme.appTheme == ThemeMode.system) {
        theme.changeAppThemeRead(ThemeMode.system);
      }
    };
  }

  Future<void> _appInitialize() async {
    await LottieCache.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    late final theme = ref.watch(themeProvider);

    return FutureBuilder<void>(
      future: init,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return MaterialApp(
            theme: theme.themeData,
            home: const WaitingScreenWidget(),
            debugShowCheckedModeBanner: false,
          );
        }

        return const MyApp();
      },
    );
  }
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final theme = ref.watch(themeProvider);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: appTitle,
      theme: theme.themeData,
      home: GetPlatform.isWeb ? const SplashScreen() : const ConnectivityWidgetWrapper(child: SplashScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
