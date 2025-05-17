import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/counter_and_change_button/riverpod/counter_notifier.dart';

final counterProvider = StateNotifierProvider<CounterNotifier,int>((ref){
  return CounterNotifier();
});

// final counterProvider = ChangeNotifierProvider<CounterNotifier>((ref) {
//   return CounterNotifier();
// });