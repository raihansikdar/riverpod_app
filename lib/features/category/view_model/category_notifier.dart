import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/category/model/category_model.dart';
import 'package:riverpod_app/features/category/repository/category_repository.dart';

class CategoryNotifier extends StateNotifier<AsyncValue<List<CategoryModel>>>{

  final CategoryRepository categoryRepository;
  CategoryNotifier(this.categoryRepository):super(const AsyncLoading()){
    getCategoryList();
  }

  Future<void>getCategoryList()async{
    try{
      final category = await categoryRepository.getCategoryList();
      state = AsyncData(category);
    }catch(e,st){
      state = AsyncError(e, st);
    }
  }

}