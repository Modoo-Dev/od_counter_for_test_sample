import 'package:flutter_test/flutter_test.dart';
import 'package:od_counter/counter.dart';
import 'package:od_counter/mock_shared_preferences.dart';

main() {
  late Counter counter;
  setUpAll(() {
    counter = Counter();
  });
  
  group('Counter Tests with SharedPreferences', () { 
     late MockSharedPreferences mockPrefs;
      late Counter counter;

      setUp(() async {
        mockPrefs = MockSharedPreferences();
        SharedPreferences.setMockInitialValues({}); // Important: set initial values
        // Ensure SharedPreferences.getInstance() returns the mock
        when(SharedPreferences.getInstance()).thenAnswer((_) async => mockPrefs);
        counter = Counter();
        await counter.loadCount(); // Load initial count at the start of each test
      });

     group('count 값 read', () { 
      test('SharedPreference에 count값을 성공적으로 load합니다.', () {
        final readCount=counter.loadCount();
        expect(readCount, isA<int>());
      });
     
    });
    group('count 값 저장', () { 
     

      test('SharedPreference에 count값을 성공적으로 저장합니다.', () async{
        counter.count=3;
        counter.saveCount();

        final readCount=counter.loadCount();
        expect(readCount, 3);

      });
      test('SharedPreference에 count값 저장시 exception 발생합니다.', () {
        //강제로 exception은 어떻게 만들지?
      });
    });
  });
 
}



    // test('count값을 local에서 읽어옴. default 0', () async{
      
    // });
    // test('count값을 local storage에 저장함', () async{
      
    // });

