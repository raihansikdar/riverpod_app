import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/auth/login/repository/login_repository.dart';
import 'package:riverpod_app/features/auth/login/repository/login_repository_impl.dart';
import 'package:riverpod_app/features/auth/login/riverpod/login_notifier.dart';


final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl();
});

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<bool>>((ref) {
       final repository = ref.watch(loginRepositoryProvider);
       return LoginNotifier(repository);
    });




