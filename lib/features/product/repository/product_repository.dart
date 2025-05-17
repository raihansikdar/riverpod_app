import 'package:riverpod_app/features/product/model/product_model.dart';

abstract class ProductRepository{
  Future<List<ProductModel>>getAllProducts();
}