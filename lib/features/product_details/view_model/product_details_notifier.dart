import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/product_details/model/product_details_model.dart';
import 'package:riverpod_app/features/product_details/repository/product_details_repository.dart';

class ProductDetailsNotifier extends StateNotifier<AsyncValue<ProductDetailsModel>> {
  final ProductDetailsRepository productDetailsRepository;

  ProductDetailsNotifier(this.productDetailsRepository): super(const AsyncValue.loading());

  Future<void> getProductDetails({required int productId}) async {
    state = const AsyncLoading();
    try{
      final productDetails = await productDetailsRepository.getProductDetails(productId: productId);
      state = AsyncData(productDetails);
    }catch(e,st){
      state = AsyncError(e, st);}
  }
}
