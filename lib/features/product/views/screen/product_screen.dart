import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/features/category/view_model/category_provider.dart';
import 'package:riverpod_app/features/product/view_model/product_provider.dart';


class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: (){
           // context.push('/test');
          }, icon: Icon(Icons.nature))
        ],

      ),

      body: Column(
        children: [

        Consumer(
          builder: (context,ref,child) {
            final categoryState = ref.watch(categoryProvider);
            return categoryState.when(
              data: (category) {
                return SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () {
                          //final categoryName = categoryState.categoryList[index].name;
                          // context.push('/home/categoryWishProduct/$categoryName');
                          log(category[index].name);
                       //   debugPrint(GoRouter.of(context).toString()); // If this crashes, context isn't within a GoRouter

                          //context.push(RoutesPath.categoryWiseProduct(categoryName: category[index].name ?? ''));

                          GoRouter.of(context).push(RoutesPath.categoryWiseProduct(categoryName: category[index].name ?? ''));

                        },

                        child: Card(
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: Center(child: Text(category[index].name,style: TextStyle(fontSize: 20),)),),
                        ),
                      );
                    }
                ),
                      );
              },
              error: (error, _) => Center(child: Text('Error: $error')),
              loading: () => Center(child: CircularProgressIndicator(),),
            );
          }
        ),



           Consumer(
             builder: (context,ref,child) {

             final productState = ref.watch(productProvider);

               return productState.when(
                 data: (product) {
                   if (product.isEmpty) {
                     return const Center(child: Text('No products available.'));
                   }
                   return Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(10),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7, // Adjust for image + text layout
                              ),
                              itemCount: product.length,
                              itemBuilder: (context, index) {
                                //final product = _productState.productList[index];
                                return GestureDetector(
                                  onTap: (){

                                  },
                                  child: Card(
                                    elevation: 4,
                                   // color:_productState.selectedIndex == index ? Colors.red :Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                            child: Image.network(
                                              product[index].image ?? '',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            product[index].title ?? '',
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
                                                "\$ ${product[index].price}",
                                                style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "${product[index].rating?.rate}",
                                              style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "(${product[index].rating?.count})",
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
                            ),
                          );
                 },
                 error: (error, _) => Center(child: Text('Error: $error')),
                 loading: () => Center(child: CircularProgressIndicator(),),
               );
             }
           )
        ],
      ),
    );
  }
}
