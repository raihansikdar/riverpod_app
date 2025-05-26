import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/auth/login/repository/login_repository.dart';

class LoginNotifier extends StateNotifier<AsyncValue<bool>> {
  // final LoginRepositoryImpl _repository = LoginRepositoryImpl();
  final LoginRepository loginRepository;

  LoginNotifier(this.loginRepository) : super(const AsyncData(false));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      final isSuccess = await loginRepository.login(email: email,password: password);
      state = AsyncData(isSuccess);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
