import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/category/model/category_model.dart';
import 'package:riverpod_app/features/category/repository/category_repository.dart';
import 'package:riverpod_app/features/category/repository/category_repository_impl.dart';
import 'package:riverpod_app/features/category/view_model/category_notifier.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl();
});

final categoryProvider = StateNotifierProvider<CategoryNotifier, AsyncValue<List<CategoryModel>>>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return CategoryNotifier(repository);
});
