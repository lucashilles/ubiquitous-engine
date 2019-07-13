import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/enum/CurrentState.dart';

class Pomodoro with ChangeNotifier {
  int _taskTime;
  int _shortPause;
  int _longPause;
  int _taskQTD;
  int _taskCount = 0;
  Stopwatch _stopWatch;
  CurrentState _state = CurrentState.waiting;
  Timer _timer;

  Pomodoro();

  int get taskTime => _taskTime;
  int get shortPause => _shortPause;
  int get longPause => _longPause;
  int get taskCount => _taskQTD;
  CurrentState get state => _state;
  Duration get elapsed => _stopWatch.elapsed;

  setConfig(int taskTime, int shortPause, int longPause, int taskQTD) {
    _taskTime = taskTime;
    _shortPause = shortPause;
    _longPause = longPause;
    _taskQTD = taskQTD;
    notifyListeners();
  }

  start() {
    _stopWatch.start();

    if (_state == CurrentState.waiting) {
      _state = CurrentState.task;
      Duration interval = Duration(seconds: 1);
      _timer = new Timer.periodic(interval, (Timer t) => shouldNotify());
    }
  }

  pause() {
    _stopWatch.stop();
  }

  stop() {
    _stopWatch.stop();
    _stopWatch.reset();
    _timer.cancel();
  }

  shouldNotify() {
    if (_state != CurrentState.waiting) {
      notifyListeners();

      switch (_state) {
        case CurrentState.task:
          if (_stopWatch.elapsed.inMinutes >= _taskTime &&
              _taskCount < _taskQTD) {
            _state = CurrentState.shortPause;
            _taskCount++;
            _stopWatch.reset();
          } else if (_stopWatch.elapsed.inMinutes >= _taskTime &&
              _taskCount >= _taskQTD) {
            _state = CurrentState.longPause;
            _taskCount = 0;
            _stopWatch.reset();
          }
          break;
        case CurrentState.shortPause:
          if (_stopWatch.elapsed.inMinutes >= _shortPause) {
            _state = CurrentState.task;
            _stopWatch.reset();
          }
          break;
        case CurrentState.longPause:
          if (_stopWatch.elapsed.inMinutes >= _longPause) {
            _state = CurrentState.task;
            _stopWatch.reset();
          }
          break;
        default:
      }
    }
  }
}
