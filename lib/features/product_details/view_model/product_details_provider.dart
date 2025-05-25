import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/product_details/model/product_details_model.dart';
import 'package:riverpod_app/features/product_details/repository/product_details_repository.dart';
import 'package:riverpod_app/features/product_details/repository/product_details_repository_impl.dart';
import 'package:riverpod_app/features/product_details/view_model/product_details_notifier.dart';

final productDetailsRepositoryProvider = Provider<ProductDetailsRepository>((ref) {
  return ProductDetailsRepositoryImpl();
});

final productDetailsProvider = StateNotifierProvider<ProductDetailsNotifier,AsyncValue<ProductDetailsModel>>((ref) {
  final repository = ref.watch(productDetailsRepositoryProvider);
  return ProductDetailsNotifier(repository);
});
