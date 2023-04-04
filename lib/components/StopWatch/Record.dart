import 'package:flutter/material.dart';

class Record extends StatelessWidget {
  final List<TimeRecord> record;

  const Record({super.key, required this.record});

  String durationToString(Duration duration) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";
    return commonStr + highlightStr;
  }

  Widget build(context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: _buildRecordItem,
        itemCount: record.length,
      ),
    );
  }

  final EdgeInsets itemPadding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 4);
  Widget _buildRecordItem(context, int index) {
    int reverseIndex = (record.length - 1) - index; // 反转索引
    bool lightIndex = reverseIndex == record.length - 1;
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
          durationToString(record[reverseIndex].record),
          style: TextStyle(color: indexColor),
        ),
        const Spacer(),
        Padding(
          padding: itemPadding,
          child: Text(
            "+" + durationToString(record[reverseIndex].addition),
            style: TextStyle(color: indexColor),
          ),
        ),
      ],
    );
  }
}

class TimeRecord {
  final Duration record; // 当前时刻
  final Duration addition; // 与上一时刻差值

  const TimeRecord({
    required this.record,
    required this.addition,
  });
}
