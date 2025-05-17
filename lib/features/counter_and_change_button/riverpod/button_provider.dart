import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/counter_and_change_button/riverpod/button_notifier.dart';

final buttonProvider = StateNotifierProvider<ButtonNotifier,int>((ref){
       return ButtonNotifier();
});

