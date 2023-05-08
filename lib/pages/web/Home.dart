import 'package:flutter/material.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:flutter_box/components/AnimatedAlignExample.dart';
import 'package:flutter_box/components/AnimatedContainerExample.dart';
import 'package:flutter_box/components/AnimatedPaddingExample.dart';
import 'package:flutter_box/components/AnimatedPositionedExample.dart';
import 'package:flutter_box/components/AnimatedText.dart';
import 'package:flutter_box/components/InnerShadowExample.dart';
import 'package:flutter_box/components/RotateAnima.dart';
import 'package:flutter_box/components/StopWatch/StopWatch.dart';
import 'package:flutter_box/components/TweenAnimationBuilderExample.dart';
import 'package:flutter_box/pages/web/AppTitle.dart';
import 'package:flutter_box/pages/web/components/LeftNav.dart';
import 'package:flutter_box/pages/web/components/RightContent.dart';
import 'package:flutter_box/utils/RandomColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _navIndex = 0;
  late ThemeConfig themeProvider;
  late LocalConfig localProvider;
  List<Locale> _locales = [Locale('zh'), Locale('en')];

  void _onThemeChange() {
    themeProvider.setTheme(themeProvider.getTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light());
  }

  void _onLocalChanged(v) {
    localProvider.setLocal(v);
  }

  void _onNavChange(i) {
    setState(() {
      _navIndex = i;
    });
  }

  Widget build(context) {
    themeProvider = Provider.of<ThemeConfig>(context);
    localProvider = Provider.of<LocalConfig>(context);

    AppBar _appbar = AppBar(
      backgroundColor: RandomColor.getColor(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTitle(),
          Row(
            children: [
              GestureDetector(
                onTap: _onThemeChange,
                child: Icon(
                  themeProvider.getTheme == ThemeData.light()
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              ),
              SizedBox(width: 20),
              DropdownButton(
                value: localProvider.getLocal,
                items: _locales
                    .map(
                      (l) => DropdownMenuItem(
                        value: l,
                        child: Text(
                          l.toString(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: _onLocalChanged,
              ),
            ],
          ),
        ],
      ),
      // backgroundColor: Color(0xffE8DEF8),
    );

    return Scaffold(
      appBar: _appbar,
      body: Center(
        child: Container(
          child: Row(
            children: [
              LeftNav(onNavChange: _onNavChange),
              RightContent(_navIndex),
              // SizedBox(
              //   width: 200,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.implicitlyAnima),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             AnimatedContainerExample(),
              //             AnimatedPaddingExample(),
              //             AnimatedAlignExample(),
              //             TweenAnimationBuilderExample(),
              //             AnimatedPositionedExample(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 20),
              // SizedBox(
              //   width: 400,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.animatedWidget),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             RotateAnima(),
              //             // AnimatedText(),
              //             // InnerShadowExample(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 20),
              // SizedBox(
              //   width: 300,
              //   child: Column(
              //     children: [
              //       Text(AppLocalizations.of(context)!.draw),
              //       Expanded(
              //         child: ListView(
              //           children: [
              //             StopWatch(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
