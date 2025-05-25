import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/features/category_wise_product/view_model/category_wise_provider.dart';

class CategoryWiseProductScreen extends ConsumerWidget {
  final String categoryName;
  const CategoryWiseProductScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context,WidgetRef ref) {


      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryProductProvider.notifier).getCategoryWiseProduct(categoryName: categoryName);
      });
    return Scaffold(
      appBar: AppBar(title: Text(categoryName),),
      body:   Consumer(
        builder: (context,ref,child) {
          final categoryList = ref.watch(categoryProductProvider);
           return  categoryList.when(
              data: (categoryList){
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.7, // Adjust for image + text layout
                  ),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    // final product = categoryWiseProductState.categoryWiseProductList[index];
                    return GestureDetector(
                      onTap: (){
                        // context.push('/home/categoryWishProduct/$categoryName/productDetails/${product.id}');

                        // context.push(RoutesPath.productDetails(categoryName: categoryName, productId: product.id ?? 0));
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                child: Image.network(
                                  categoryList[index].image ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categoryList[index].title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "${categoryList[index].price}",
                                    style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${categoryList[index].rating?.rate}",
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "(${categoryList[index].rating?.count})",
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
          error: (error, _) => Center(child: Text('Error: $error')),
          loading: () => Center(child: CircularProgressIndicator()),
          );
        }
      ),





    );
  }
}