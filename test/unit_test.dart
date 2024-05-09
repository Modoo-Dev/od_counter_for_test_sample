import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:od_counter/counter.dart';

main() {
  late Counter counter;
  setUpAll(() {
    counter = Counter();
  });
  group('basic_count_increase_decrease_test', () { 
    test('Counter 객체의 count 값이 0에서 시작해야함', () {
      expect(counter.count, 0);
    });

    test('Counter 객체의 count값이 하나 증가해야함', () {
      counter.incrementCounter();
      expect(counter.count, 1);
    });
    test('Counter 객체의 count값이 하나 감소해야함', () {
      counter.count=1;
      counter.decreaseCounter();
      expect(counter.count, 0);
    });
  });
  
  group('timer_test', () { 
    test('Counter 객체의 count값이 1초마다 감소해야함', () {
      fakeAsync((async) {
        counter.count=30;//count값을 30으로 셋팅
        counter.startDecreaseTimer();//타이머 시작
        async.elapse(const Duration(seconds: 30));//가짜로 30초를 진행시킴
        expect(counter.count, 0);
      });
    });
     tearDownAll(() {
      counter.timer.cancel();
    });
  });
  
  
}


