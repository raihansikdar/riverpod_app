import 'dart:developer';

import 'package:riverpod_app/core/app_urls/app_urls.dart';
import 'package:riverpod_app/core/services_network/network_caller.dart';
import 'package:riverpod_app/core/services_network/network_response.dart';
import 'package:riverpod_app/core/utility/exception/debug_logger.dart';
import 'package:riverpod_app/features/category_wise_product/model/category_wise_producr_model.dart';
import 'package:riverpod_app/features/category_wise_product/repository/category_wise_product_repository.dart';

class CategoryWiseProductRepositoryImpl implements CategoryWiseProductRepository{
  @override
  Future<List<CategoryWiseProductModel>> getCategoryWiseProduct({required String categoryName}) async{

    try{
      NetworkResponse response = await NetworkCaller.getRequest(AppUrls.getCategoryWiseProductUrl(categoryName: categoryName));

      DebugLogger.printJsonResponse(
          tag: 'getCategoryWiseProductUrl',
          responseBody: response.body,
          statusCode: response.statusCode,
      );

      if(response.isSuccess){
        return (response.body as List).map((json)=>CategoryWiseProductModel.fromJson(json)).toList();
      }else{
        throw Exception('Failed to fetch category wise product data');
      }
    }catch (e, stackTrace) {
      log('Error in getCategoryWiseProductUrl: $e');
      log('StackTrace: $stackTrace');
      throw Exception('Something went wrong while fetching category wise products');
    }
  }

}