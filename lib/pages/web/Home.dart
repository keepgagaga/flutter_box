import 'package:flutter/material.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isDark = false;
  var themeProvider;

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

  Widget build(context) {
    themeProvider = Provider.of<ThemeConfig>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Flutter Box',
              // style: TextStyle(color: Colors.black),
            ),
            Switch(value: _isDark, onChanged: _onThemeChanged),
          ],
        ),
        // backgroundColor: Color(0xffE8DEF8),
      ),
      body: Center(
        child: Container(
            // color: Color(0xffF2EBE0),
            ),
      ),
    );
  }
}
