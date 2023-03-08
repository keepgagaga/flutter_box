import 'package:flutter/material.dart';

class LeftArea extends StatefulWidget {
  _LeftAreaState createState() => _LeftAreaState();
}

class _LeftAreaState extends State<LeftArea> {
  int _selectedDestination = 0;

  Widget build(context) {
    double leftW = 80;
    Size size = MediaQuery.of(context).size;

    return Container(
      width: leftW,
      height: size.height,
      child: NavigationRail(
        backgroundColor: Colors.greenAccent,
        selectedIndex: _selectedDestination,
        onDestinationSelected: (value) => {
          setState(() {
            _selectedDestination == value;
          })
        },
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.grid_view),
            label: Text('components'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.settings),
            label: Text('settings'),
          ),
        ],
      ),
    );
  }
}
