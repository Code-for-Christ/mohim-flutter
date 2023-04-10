import 'dart:async';

class Debounce {
  final Duration duration;
  Timer? _timer;
  Function? _action;

  Debounce(this.duration);

  void call(Function action) {
    _action = action;
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(duration, _debouncedAction);
  }

  void _debouncedAction() async {
    _action?.call();
    _action = null;
  }
}
