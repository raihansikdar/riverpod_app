import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonNotifier extends StateNotifier<int>{
  ButtonNotifier():super(0);
  void updateButton({required int value}){
    state = value;
  }
}