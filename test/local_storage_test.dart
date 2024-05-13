import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:od_counter/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'local_storage_test.mocks.dart';

main() {
  late MockSharedPreferences mockPrefs;
  late Counter counter;

  setUpAll(() {
    mockPrefs = MockSharedPreferences();
    counter = Counter(mockPrefs);
    when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
  });

  group('count 값 read', () {
    test('SharedPreference에 count값을 성공적으로 load합니다.', () async {
      await counter.loadCount();
      expect(counter.count, isA<int>());
    });
  });
  group('count 값 save', () {

    test('SharedPreference에 count값을 성공적으로 저장합니다.', () async {
      counter.count = 3;
      await counter.saveCount();
      verify(mockPrefs.setInt('counter', 3)).called(1);
    });
    test('SharedPreference에 count값 저장시 exception 발생합니다.', () {
      //강제로 exception은 어떻게 만들지?
    });
  });
}

