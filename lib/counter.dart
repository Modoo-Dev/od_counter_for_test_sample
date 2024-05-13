import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
class Counter {
  int count = 0;
  late Timer _timer;
  Timer get timer => _timer;
  SharedPreferences? sharePreference;
  Counter([this.sharePreference]);
  
  void incrementCounter() {
    count++;
  }

  void decreaseCounter() {
    count--;
  }
  void startDecreaseTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        decreaseCounter();
    });
  }

  Future<void> saveCount() async {
    try{
      final prefs=sharePreference??await SharedPreferences.getInstance();
      
      final result=await prefs.setInt('counter', 3);
      if(!result){
        throw('setInt return false');
      }
      
    }catch(e){
      print(e);
      throw(Exception('local storage 저장에 문제뱔생'));
    }
  }

  Future<void> loadCount() async {
    final prefs=sharePreference??await SharedPreferences.getInstance();
    count = prefs.getInt('counter') ?? 0;
    
  }
}


