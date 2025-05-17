import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_app/core/app_urls/app_urls.dart';
import 'package:riverpod_app/core/services_network/network_caller.dart';
import 'package:riverpod_app/core/services_network/network_response.dart';
import 'package:riverpod_app/features/category/model/category_model.dart';
import 'package:riverpod_app/features/category/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  @override
  Future<List<CategoryModel>> getCategoryList() async{

    try{
      NetworkResponse response = await NetworkCaller.getRequest(AppUrls.getAllCategoryUrl);


     // const encoder = JsonEncoder.withIndent('  ');
      //final prettyJson = encoder.convert(jsonDecode(response.body));
      log("getRequest statusCode ==> ${response.statusCode}");
      log("getRequest body ==> ${response.body}");

      if(response.isSuccess){
        return (response.body as List<dynamic>)
            .map((name) => CategoryModel.fromJson(name as String))
            .toList();
      }else{
        throw Exception('Failed to fetch category data');
      }
    }catch (e, stackTrace) {
      log('Error in category: $e');
      log('StackTrace: $stackTrace');
      throw Exception('Something went wrong while fetching category');
    }
  }

}