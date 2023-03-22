import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        ],
        child: MainApp(),
      ),
      // ChangeNotifierProvider<ThemeConfig>(
      //   create: (_) => ThemeConfig(ThemeData.light()),
      //   child: MainApp(),
      // ),
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

    return MaterialApp(
      title: 'Flutter Box',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: kIsWeb
          ? Web.Home()
          : ((Platform.isMacOS || Platform.isWindows || Platform.isLinux)
              ? Desktop.Home()
              : Mobile.Home()),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: localData,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Box',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        backgroundColor: Color(0xffE8DEF8),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: kIsWeb
          ? Web.Home()
          : ((Platform.isMacOS || Platform.isWindows || Platform.isLinux)
              ? Desktop.Home()
              : Mobile.Home()),
    );
  }
}
