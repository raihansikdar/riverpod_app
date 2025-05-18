import 'package:riverpod_app/features/category_wise_product/model/category_wise_producr_model.dart';

abstract class CategoryWiseProductRepository{
  Future<List<CategoryWiseProductModel>>getCategoryWiseProduct({required String categoryName});
}