import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/product_details/view_model/product_details_provider.dart';


class ProductDetailsScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productDetailsProvider.notifier).getProductDetails(productId: productId);
    });
    return Scaffold(
      appBar: AppBar(title: Text("Details"),),
      body: Consumer(
        builder: (context,ref,child) {
          final productDetails = ref.watch(productDetailsProvider);
          return productDetails.when(
            data: (product) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10)),
                    child: Image.network(
                      product.image ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text(product.description.toString()),
                        SizedBox(height: 10,),
                        Text("\$ ${product.price}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                ],
              );
            },
            error: (error, _) => Center(child: Text('Error: $error')),
            loading: () => Center(child: CircularProgressIndicator(),),
          );
        }
      )
    );
  }
}