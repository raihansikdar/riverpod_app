import 'dart:developer';

import 'package:riverpod_app/core/app_urls/app_urls.dart';
import 'package:riverpod_app/core/services_network/network_caller.dart';
import 'package:riverpod_app/core/services_network/network_response.dart';
import 'package:riverpod_app/features/product_details/model/product_details_model.dart';
import 'package:riverpod_app/features/product_details/repository/product_details_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  @override
  Future<ProductDetailsModel> getProductDetails({required int productId}) async {
    try {
      NetworkResponse response = await NetworkCaller.getRequest(
        AppUrls.getProductDetailsUrl(id: productId),
      );

      if (response.isSuccess) {
        return ProductDetailsModel.fromJson(response.body);
      } else {
        throw Exception('Something went wrong while fetching products details');
      }
    } catch (e, stackTrace) {
      log('Error in getCategoryWiseProductUrl: $e');
      log('StackTrace: $stackTrace');
      throw Exception('Something went wrong while fetching products details');
    }
  }
}
