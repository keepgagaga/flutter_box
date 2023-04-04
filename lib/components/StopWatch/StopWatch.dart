import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_box/components/StopWatch/ControlButton.dart';
import 'package:flutter_box/components/StopWatch/Record.dart';

import 'StopWatchWidget.dart';

class StopWatch extends StatefulWidget {
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late Ticker _ticker;
  Duration dt = Duration.zero;
  Duration lastDuration = Duration.zero;
  StopWatchType _stopWatchType = StopWatchType.none;
  List<TimeRecord> _record = [];

  @override
  void initState() {
    _ticker = Ticker(_onTick);
    super.initState();
  }

  @override
  void dispose() {
    duration.dispose();
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    setState(() {
      dt = elapsed - lastDuration;
      duration.value += dt;
      lastDuration = elapsed;
    });
  }

  void _onReset() {
    setState(() {
      _stopWatchType = StopWatchType.none;
      duration.value = Duration.zero;
      _record.clear();
    });
  }

  void _onRecord() {
    Duration current = duration.value;
    Duration addition = duration.value;
    if (_record.isNotEmpty) {
      addition = duration.value - _record.last.record;
    }
    setState(() {
      _record.add(TimeRecord(record: current, addition: addition));
    });
  }

  void _toggle() {
    bool running = _stopWatchType == StopWatchType.running;
    if (running) {
      _ticker.stop();
      lastDuration = Duration.zero;
    } else {
      _ticker.start();
    }
    setState(() {
      _stopWatchType = running ? StopWatchType.stopped : StopWatchType.running;
    });
  }

  ValueNotifier<Duration> duration = ValueNotifier(Duration.zero);

  Widget build(context) {
    return Container(
      width: 300,
      height: 800,
      child: Column(
        children: [
          Container(
            height: 300,
            child: ValueListenableBuilder<Duration>(
              valueListenable: duration,
              builder: (_, value, __) => StopWatchWidget(
                duration: duration.value,
                radius: 150,
              ),
            ),
          ),
          Record(record: _record),
          ControlButton(
            state: _stopWatchType,
            toggle: _toggle,
            onReset: _onReset,
            onRecord: _onRecord,
          ),
        ],
      ),
    );
  }
}
