import 'package:flutter/material.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
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

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Container(
          child: Text(AppLocalizations.of(context)!.helloWorld),
        ),
      ),
    );
  }
}
