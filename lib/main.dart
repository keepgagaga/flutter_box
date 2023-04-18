import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:flutter_box/components/StopWatch/StopWatchBloc.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/desktop/Home.dart' as Desktop;
import 'pages/mobile/Home.dart' as Mobile;
import 'pages/web/Home.dart' as Web;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeConfig>(
            create: (_) => ThemeConfig(ThemeData.light()),
          ),
          ChangeNotifierProvider<LocalConfig>(
            create: (_) => LocalConfig(Locale('zh')),
          ),
          BlocProvider<StopWatchBloc>(
            create: (_) => StopWatchBloc(),
          ),
        ],
        child: MainApp(),
      ),
    );
  } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      size: Size(800, 600),
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeConfig>(
          create: (_) => ThemeConfig(ThemeData.light()),
        ),
        ChangeNotifierProvider<LocalConfig>(
          create: (_) => LocalConfig(Locale('zh')),
        ),
        BlocProvider<StopWatchBloc>(
          create: (_) => StopWatchBloc(),
        ),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget build(context) {
    final themeProvider = Provider.of<ThemeConfig>(context);
    final themeData = themeProvider.getTheme;

    final localProvider = Provider.of<LocalConfig>(context);
    final localData = localProvider.getLocal;

    Widget getHome() {
      if (kIsWeb) return Web.Home();
      if (Platform.isAndroid || Platform.isIOS) return Mobile.Home();
      return Desktop.Home();
    }

    return MaterialApp(
      title: 'Flutter Box',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: getHome(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localData,
    );
  }
}
