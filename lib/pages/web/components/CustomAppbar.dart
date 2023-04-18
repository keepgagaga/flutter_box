import 'package:flutter/material.dart';
import 'package:flutter_box/common/LocalConfig.dart';
import 'package:flutter_box/common/ThemeConfig.dart';
import 'package:flutter_box/utils/RandomColor.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
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

  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget build(context) {
    themeProvider = Provider.of<ThemeConfig>(context);
    localProvider = Provider.of<LocalConfig>(context);

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Flutter Box',
            style: TextStyle(
              color: RandomColor.getColor(),
            ),
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
  }
}
