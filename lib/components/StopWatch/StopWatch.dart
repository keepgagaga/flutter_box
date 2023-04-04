import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

  void onReset() {
    setState(() {
      _stopWatchType = StopWatchType.none;
      duration.value = Duration.zero;
      _record.clear();
    });
  }

  void onRecoder() {
    Duration current = duration.value;
    Duration addition = duration.value;
    if (_record.isNotEmpty) {
      addition = duration.value - _record.last.record;
    }
    setState(() {
      _record.add(TimeRecord(record: current, addition: addition));
    });
  }

  void toggle() {
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

  void updateDuration() {
    int minus = duration.value.inMinutes % 60;
    int second = duration.value.inSeconds % 60;
    int milliseconds = duration.value.inMilliseconds % 1000;
    duration.value = Duration(
        minutes: minus, seconds: second, milliseconds: milliseconds + 100);
    setState(() {});
  }

  Widget build(context) {
    return Container(
      width: 300,
      height: 800,
      child: Column(
        children: [
          buildStopWatchPanel(),
          buildRecordPanel(),
          buildTools(_stopWatchType),
        ],
      ),
    );
  }

  Widget buildStopWatchPanel() {
    return Container(
        height: 300,
        child: ValueListenableBuilder<Duration>(
          valueListenable: duration,
          builder: (_, value, __) => StopWatchWidget(
            duration: duration.value,
            radius: 150,
            themeColor: Colors.red,
            scaleColor: Colors.blue,
            textStyle: TextStyle(),
          ),
        ));
  }

  Widget buildRecordPanel() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: _buildRecordItem,
        itemCount: _record.length,
      ),
    );
  }

  final EdgeInsets itemPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 4);
  Widget _buildRecordItem(context, int index) {
    int reverseIndex = (_record.length - 1) - index; // 反转索引
    bool lightIndex = reverseIndex == _record.length - 1;
    Color themeColor = Theme.of(context).primaryColor;
    Color? indexColor = lightIndex ? themeColor : null;

    return Row(
      children: [
        Padding(
          padding: itemPadding,
          child: Text(
            reverseIndex.toString().padLeft(2, '0'),
            style: TextStyle(color: indexColor),
          ),
        ),
        Text(
          durationToString(_record[reverseIndex].record),
          style: TextStyle(color: indexColor),
        ),
        const Spacer(),
        Padding(
          padding: itemPadding,
          child: Text(
            "+" + durationToString(_record[reverseIndex].addition),
            style: TextStyle(color: indexColor),
          ),
        ),
      ],
    );
  }

  String durationToString(Duration duration) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";
    return commonStr + highlightStr;
  }

  Widget buildTools(StopWatchType state) {
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
              onTap: running ? onRecoder : null,
            ),
        ],
      ),
    );
  }
}

enum StopWatchType {
  none,
  stopped,
  running,
}

class TimeRecord {
  final Duration record; // 当前时刻
  final Duration addition; // 与上一时刻差值

  const TimeRecord({
    required this.record,
    required this.addition,
  });
}

class StopWatchPainter extends CustomPainter {
  final double radius;
  final Duration duration; // 时长
  final Color themeColor; // 主题色
  final Color scaleColor; // 刻度色
  final TextStyle textStyle; // 文本样式
  StopWatchPainter({
    required this.radius,
    required this.duration,
    required this.themeColor,
    required this.scaleColor,
    required this.textStyle,
  });

  final Paint scalePainter = Paint();
  final Paint indicatorPainter = Paint();

  TextStyle commonStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w200,
    color: const Color(0xff343434),
  );
  TextStyle highlightStyle = TextStyle();

  void paint(Canvas canvas, Size size) {
    const double _kScaleWidthRate = 0.4 / 10;
    const double _kIndicatorRadiusRate = 0.4 / 15;
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    final double indicatorRadius = size.width * _kIndicatorRadiusRate;

    canvas.translate(size.width / 2, size.height / 2); // tag1
    scalePainter
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 180; i++) {
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0), scalePainter);
      canvas.rotate(pi / 180 * 2); //这里采用 rotate 整个 canvas 而不是单个线
    }

    TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // final Duration duration =
    //     Duration(minutes: 0, seconds: 4, milliseconds: 650);

    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";

    void drawText(Canvas canvas) {
      textPainter.text = TextSpan(
          text: commonStr,
          style: commonStyle,
          children: [TextSpan(text: highlightStr, style: highlightStyle)]);
      textPainter.layout(); // 进行布局
      final double width = textPainter.size.width;
      final double height = textPainter.size.height;
      textPainter.paint(canvas, Offset(-width / 2, -height / 2));
    }

    drawText(canvas);

    double radians = (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi;

    canvas.save();
    canvas.rotate(radians);
    canvas.drawCircle(
      Offset(
        0,
        -size.width / 2 + scaleLineWidth + indicatorRadius,
      ),
      indicatorRadius / 2,
      indicatorPainter,
    );
    canvas.restore();
  }

  bool shouldRepaint(covariant StopWatchPainter oldDelegate) {
    return oldDelegate.duration != duration ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.themeColor != themeColor ||
        oldDelegate.scaleColor != scaleColor;
  }
}

class StopWatchWidget extends StatelessWidget {
  final Duration duration;
  final double radius;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  const StopWatchWidget(
      {super.key,
      required this.duration,
      required this.radius,
      required this.themeColor,
      required this.scaleColor,
      required this.textStyle});

  Widget build(context) {
    return Container(
      child: CustomPaint(
        painter: StopWatchPainter(
          radius: 150,
          duration: duration,
          themeColor: Colors.red,
          scaleColor: Colors.blue,
          textStyle: TextStyle(),
        ),
        size: Size(300, 300),
      ),
    );
  }
}
