import 'package:riverpod_app/features/category/model/category_model.dart';

abstract class CategoryRepository{
  Future<List<CategoryModel>>getCategoryList();
}