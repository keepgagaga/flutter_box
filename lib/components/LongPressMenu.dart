import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LongPressMenu extends StatefulWidget {
  _LongPressMenuState createState() => _LongPressMenuState();
}

class _LongPressMenuState extends State<LongPressMenu> {
  Widget build(context) {
    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          trailingIcon: CupertinoIcons.share,
          child: const Text("Share"),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          trailingIcon: CupertinoIcons.down_arrow,
          child: const Text("Save"),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: const Text("Delete"),
        )
      ],
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
