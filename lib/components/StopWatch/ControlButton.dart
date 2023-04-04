import 'package:flutter/material.dart';

import 'StopWatchState.dart';

class ControlButton extends StatelessWidget {
  final StopWatchType state;
  final VoidCallback? toggle;
  final VoidCallback? onReset;
  final VoidCallback? onRecord;

  const ControlButton(
      {super.key,
      required this.state,
      this.toggle,
      this.onReset,
      this.onRecord});

  Widget build(context) {
    bool running = state == StopWatchType.running;
    bool stopped = state == StopWatchType.stopped;
    Color activeColor = const Color(0xff3A3A3A);
    Color inactiveColor = const Color(0xffDDDDDD);
    Color resetColor = stopped ? activeColor : inactiveColor;
    Color flagColor = running ? activeColor : inactiveColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 50,
        children: [
          if (state != StopWatchType.none)
            GestureDetector(
              child: Icon(Icons.refresh, size: 28, color: resetColor),
              onTap: stopped ? onReset : null,
            ),
          FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child:
                running ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
            onPressed: toggle,
          ),
          if (state != StopWatchType.none)
            GestureDetector(
              child: Icon(Icons.flag_outlined, size: 28, color: flagColor),
              onTap: running ? onRecord : null,
            ),
        ],
      ),
    );
  }
}
