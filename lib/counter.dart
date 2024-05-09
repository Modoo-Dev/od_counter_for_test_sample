import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class Counter {
  int count = 0;
  late Timer _timer;


  Timer get timer => _timer;
  
  void incrementCounter() {
    count++;
  }

  void decreaseCounter() {
    count;
  }
  void startDecreaseTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        decreaseCounter();
    });
  }

  Future<void> saveCount() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('counter', count);
    }catch(e){
      throw(Exception('local storage 저장에 문제뱔생'));
    }
    
  }

  Future<void> loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt('counter') ?? 0;
  }
}


