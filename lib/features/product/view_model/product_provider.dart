import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/product/model/product_model.dart';
import 'package:riverpod_app/features/product/repository/product_repository.dart';
import 'package:riverpod_app/features/product/repository/product_repository_impl.dart';
import 'package:riverpod_app/features/product/view_model/product_notifier.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final productProvider = StateNotifierProvider<ProductViewModelNotifier, AsyncValue<List<ProductModel>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductViewModelNotifier(repository);
});
