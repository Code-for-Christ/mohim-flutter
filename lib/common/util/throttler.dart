import 'dart:async';

class Throttler {
  Timer? _timer;
  bool waiting = true;

  void throttle(Duration duration, void Function() callback) {
    if (waiting) {
      callback();
      waiting = false;
      _timer = Timer(duration, () {
        waiting = true;
      });
    }
    // if (_timer?.isActive ?? false) {
    //   _timer!.cancel();
    // }
  }
}

// function throttle(callback, wait) {// callback: 실행 대상인 함수
//   let waiting = true;  // true로 주어서 콜백함수가
//                         // 처음 한번은 바로 실행되도록 함
//   return function() {
//     if (waiting) {
//       callback();       
//       waiting = false;   // false로 바꿔 실행되지 않도록 한다.
//       setTimeout(() => {// wait만큼 시간이 지난 후,
//         waiting = true;// true로 바뀌면서 다시 실행됨.
//       }, wait);
//     }
//   };  
// };