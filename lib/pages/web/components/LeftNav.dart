import 'package:flutter/material.dart';

class LeftNav extends StatefulWidget {
  final double width;
  final Function onNavChange;

  const LeftNav({super.key, this.width = 70, required this.onNavChange});

  _LeftNavState createState() => _LeftNavState();
}

class _LeftNavState extends State<LeftNav> {
  int _selectedIndex = 0;

  Widget build(context) {
    Size size = MediaQuery.of(context).size;

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
        ],
      ),
    );
  }
}
