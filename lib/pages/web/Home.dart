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
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var themeProvider;
  Locale _localValue = Locale('zh');
  List<Locale> _locales = [Locale('zh'), Locale('en')];
  var localProvider;

  void _onThemeChange() {
    themeProvider.setTheme(themeProvider.getTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light());
  }

  void _onLocalChanged(v) {
    setState(() {
      _localValue = v;
      localProvider.setLocal(v);
    });
  }

  Widget build(context) {
    themeProvider = Provider.of<ThemeConfig>(context);
    localProvider = Provider.of<LocalConfig>(context);

    AppBar _appBar = AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Flutter Box',
          ),
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
                value: _localValue,
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
      appBar: _appBar,
      body: Center(
        child: Container(
          child: Row(
            children: [
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
