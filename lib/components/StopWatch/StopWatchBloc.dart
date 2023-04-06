import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'StopWatchEvent.dart';
part 'StopWatchState.dart';

class StopWatchBloc extends Bloc<StopWatchEvent, StopWatchState> {
  Ticker? _ticker;

  StopWatchBloc() : super(const StopWatchState()) {
    on<ToggleStopWatch>(_onToggleStopWatch); // 待触发的事件以及对应调用的方法
    on<ResetStopWatch>(_onResetStopWatch);
    on<RecordStopWatch>(_onRecordStopWatch);
    on<_UpdateDuration>(_onUpdateDuration);
  }

  void _initTickerWhenNull() {
    if (_ticker != null) return;
    _ticker = Ticker(_onTick);
  }

  Duration _dt = Duration.zero;
  Duration _lastDuration = Duration.zero;

  void _onTick(Duration elapsed) {
    _dt = elapsed - _lastDuration;
    add(_UpdateDuration(state.duration + _dt));
    _lastDuration = elapsed;
  }

  @override
  Future<void> close() async {
    _ticker?.dispose();
    _ticker = null;
    return super.close();
  }

  void _onToggleStopWatch(ToggleStopWatch event, Emitter<StopWatchState> emit) {
    _initTickerWhenNull();
    if (_ticker!.isTicking) {
      _ticker!.stop();
      _lastDuration = Duration.zero;
      emit(state.copyWith(type: StopWatchType.stopped));
    } else {
      _ticker!.start();
      emit(state.copyWith(type: StopWatchType.running));
    }
  }

  void _onUpdateDuration(_UpdateDuration event, Emitter<StopWatchState> emit) {
    emit(state.copyWith(duration: event.duration));
  }

  void _onResetStopWatch(ResetStopWatch event, Emitter<StopWatchState> emit) {
    _lastDuration = Duration.zero;
    _dt = Duration.zero;
    emit(const StopWatchState());
  }

  void _onRecordStopWatch(RecordStopWatch event, Emitter<StopWatchState> emit) {
    List<TimeRecord> currentList = state.durationRecord.map((e) => e).toList();
    Duration current = state.duration;
    Duration addition = state.duration;
    if (currentList.isNotEmpty) {
      addition = current - currentList.last.record;
    }
    currentList.add(TimeRecord(record: current, addition: addition));
    emit(state.copyWith(durationRecord: currentList));
  }
}
