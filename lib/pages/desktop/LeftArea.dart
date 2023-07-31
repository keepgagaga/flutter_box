import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/ThemeConfig.dart';

class LeftArea extends StatefulWidget {
  final double width;
  final Function onNavChange;

  const LeftArea({super.key, this.width = 70, required this.onNavChange});

  _LeftAreaState createState() => _LeftAreaState();
}

class _LeftAreaState extends State<LeftArea> {
  int _selectedIndex = 0;
  var themeProvider;

  void _onThemeChange() {
    themeProvider.setTheme(themeProvider.getTheme == ThemeData.light()
        ? ThemeData.dark()
        : ThemeData.light());
  }

  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    themeProvider = Provider.of<ThemeConfig>(context);

    return Container(
      width: widget.width,
      height: size.height,
      color: Color(0xffE2E4E5),
      child: Column(
        children: [
          SizedBox(
            height: size.height - 100,
            child: NavigationRail(
              backgroundColor: Color(0xffE2E4E5),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) => {
                setState(() {
                  _selectedIndex = index;
                }),
                widget.onNavChange(index)
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('One'),
                  padding: EdgeInsets.only(top: 30),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Two'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Three'),
                ),
              ],
            ),
          ),
          Container(
            width: widget.width,
            height: 100,
            child: GestureDetector(
              onTap: _onThemeChange,
              child: Icon(
                themeProvider.getTheme == ThemeData.light()
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
