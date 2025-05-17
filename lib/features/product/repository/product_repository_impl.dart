import 'dart:developer';

import 'package:riverpod_app/core/app_urls/app_urls.dart';
import 'package:riverpod_app/core/services_network/network_caller.dart';
import 'package:riverpod_app/core/services_network/network_response.dart';
import 'package:riverpod_app/features/product/model/product_model.dart';
import 'package:riverpod_app/features/product/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository{
  @override
  Future<List<ProductModel>> getAllProducts() async{

    try{
      NetworkResponse response = await NetworkCaller.getRequest(AppUrls.allProducts);
      if(response.isSuccess){
        return (response.body as List).map((json)=>ProductModel.fromJson(json)).toList().cast<ProductModel>();
      }else{
        throw Exception('Failed to fetch product data');
      }
    }catch (e, stackTrace) {
      log('Error in getAllProducts: $e');
      log('StackTrace: $stackTrace');
      throw Exception('Something went wrong while fetching products');
    }
  }

}