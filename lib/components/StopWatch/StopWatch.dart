import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_box/components/StopWatch/ControlButton.dart';
import 'package:flutter_box/components/StopWatch/Record.dart';
import 'package:flutter_box/components/StopWatch/StopWatchBloc.dart';

import 'StopWatchWidget.dart';

class StopWatch extends StatefulWidget {
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  StopWatchBloc get stopWatchBloc => BlocProvider.of<StopWatchBloc>(context);

  void _onReset() {
    stopWatchBloc.add(const ResetStopWatch());
  }

  void _onRecord() {
    stopWatchBloc.add(const RecordStopWatch());
  }

  void _toggle() {
    stopWatchBloc.add(const ToggleStopWatch());
  }

  Widget build(context) {
    return Container(
      width: 300,
      height: 800,
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            child: BlocBuilder<StopWatchBloc, StopWatchState>(
              buildWhen: (p, n) => p.duration != n.duration,
              builder: (_, state) => StopWatchWidget(
                duration: state.duration,
                radius: 150,
              ),
            ),
          ),
          BlocBuilder<StopWatchBloc, StopWatchState>(
            buildWhen: (p, n) => p.durationRecord != n.durationRecord,
            builder: (_, state) => Record(record: state.durationRecord),
          ),
          BlocBuilder<StopWatchBloc, StopWatchState>(
            buildWhen: (p, n) => p.type != n.type,
            builder: (_, state) => ControlButton(
              state: state.type,
              toggle: _toggle,
              onReset: _onReset,
              onRecord: _onRecord,
            ),
          ),
        ],
      ),
    );
  }
}
