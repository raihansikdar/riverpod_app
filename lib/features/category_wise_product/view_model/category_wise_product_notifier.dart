import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/category_wise_product/model/category_wise_producr_model.dart';
import 'package:riverpod_app/features/category_wise_product/repository/category_wise_product_repository.dart';

class CategoryWiseProductNotifier extends StateNotifier<AsyncValue<List<CategoryWiseProductModel>>> {
  final CategoryWiseProductRepository _categoryWiseProductRepository;

  CategoryWiseProductNotifier(this._categoryWiseProductRepository) : super(const AsyncValue.loading());

  Future<void> getCategoryWiseProduct({required String categoryName}) async {
    state = const AsyncLoading();
    try {
      final products = await _categoryWiseProductRepository.getCategoryWiseProduct(categoryName: categoryName);
      state = AsyncData(products);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
