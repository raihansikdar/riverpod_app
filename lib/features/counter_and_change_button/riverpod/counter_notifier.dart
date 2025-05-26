import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int>{
  CounterNotifier(): super(0);

  void increment()=>state++;

  void decrement() {
    if (state > 0) {
      state--;
    }
  }
}

// class CounterNotifier extends ChangeNotifier {
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }