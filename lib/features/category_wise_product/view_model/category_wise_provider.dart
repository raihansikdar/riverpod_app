import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/category_wise_product/model/category_wise_producr_model.dart';
import 'package:riverpod_app/features/category_wise_product/repository/category_wise_product_repository.dart';
import 'package:riverpod_app/features/category_wise_product/repository/category_wise_product_repository_impl.dart';
import 'package:riverpod_app/features/category_wise_product/view_model/category_wise_product_notifier.dart';

final categoryWiseRepositoryProvider = Provider<CategoryWiseProductRepository>((ref) {
  return CategoryWiseProductRepositoryImpl();
});

final categoryProductProvider = StateNotifierProvider<CategoryWiseProductNotifier, AsyncValue<List<CategoryWiseProductModel>>>((ref) {
  final repository = ref.watch(categoryWiseRepositoryProvider);
  return CategoryWiseProductNotifier(repository);
});