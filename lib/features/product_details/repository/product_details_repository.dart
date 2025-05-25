import 'package:riverpod_app/features/product_details/model/product_details_model.dart';

abstract class ProductDetailsRepository {
Future<ProductDetailsModel>getProductDetails({required int productId});
}