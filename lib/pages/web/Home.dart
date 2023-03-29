import 'package:flutter/material.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:flutter_box/components/AnimatedAlignExample.dart';
import 'package:flutter_box/components/AnimatedContainerExample.dart';
import 'package:flutter_box/components/AnimatedPaddingExample.dart';
import 'package:flutter_box/components/AnimatedPositionedExample.dart';
import 'package:flutter_box/components/TweenAnimationBuilderExample.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDark = false;
  var themeProvider;
  Locale _localValue = Locale('zh');
  List<Locale> _locales = [Locale('zh'), Locale('en')];
  var localProvider;

  void _onThemeChanged(v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', v);
    setState(() {
      _isDark = v;
      if (v == true) {
        themeProvider.setTheme(ThemeData.dark());
      } else {
        themeProvider.setTheme(ThemeData.light());
      }
    });
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
            // style: TextStyle(color: Colors.black),
          ),
          Row(
            children: [
              Switch(value: _isDark, onChanged: _onThemeChanged),
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
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Text('隐式动画'),
                    ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        AnimatedContainerExample(),
                        AnimatedPaddingExample(),
                        AnimatedAlignExample(),
                        TweenAnimationBuilderExample(),
                        AnimatedPositionedExample(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text('显式动画'),
                  Column(
                    children: [],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
