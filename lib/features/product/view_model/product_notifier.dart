import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/product/model/product_model.dart';
import 'package:riverpod_app/features/product/repository/product_repository.dart';

class ProductViewModelNotifier extends StateNotifier<AsyncValue<List<ProductModel>>>{

  final ProductRepository productRepository;
  ProductViewModelNotifier(this.productRepository):super(const AsyncLoading()){
      getAllProducts();
  }

  //ProductViewModelNotifier(this.productRepository):super(const AsyncValue.loading());

  Future<void>getAllProducts()async{
   // state = const AsyncLoading();
    try{
      final products = await productRepository.getAllProducts();
      state = AsyncData(products);
    }catch(e,st){
      state = AsyncError(e, st);
    }
  }

}