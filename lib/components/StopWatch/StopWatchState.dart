class StopWatchState {
  final StopWatchType type;
  final List<TimeRecord> durationRecord;
  final Duration duration;

  Duration get secondDuration {
    if (durationRecord.isNotEmpty) {
      return duration - durationRecord.last.record;
    }
    return duration;
  }

  const StopWatchState({
    this.type = StopWatchType.none,
    this.durationRecord = const [],
    this.duration = Duration.zero,
  });

  StopWatchState copyWith({
    StopWatchType? type,
    List<TimeRecord>? durationRecord,
    Duration? duration,
  }) {
    return StopWatchState(
      type: type ?? this.type,
      durationRecord: durationRecord ?? this.durationRecord,
      duration: duration ?? this.duration,
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
