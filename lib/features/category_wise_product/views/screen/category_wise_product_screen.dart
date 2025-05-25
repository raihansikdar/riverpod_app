import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/features/category_wise_product/view_model/category_wise_provider.dart';

class CategoryWiseProductScreen extends ConsumerStatefulWidget {
  final String categoryName;
  const CategoryWiseProductScreen({super.key, required this.categoryName});

  @override
  ConsumerState<CategoryWiseProductScreen> createState() => _CategoryWiseProductScreenState();
}

class _CategoryWiseProductScreenState extends ConsumerState<CategoryWiseProductScreen> {
  @override
  void initState() {
    super.initState();
    // Only called once when the screen is first created
    ref.read(categoryProductProvider.notifier).getCategoryWiseProduct(
      categoryName: widget.categoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = ref.watch(categoryProductProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: categoryList.when(
        data: (products) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  context.push(RoutesPath.productDetails(
                    categoryName: widget.categoryName,
                    productId: product.id ?? 0,
                  ));
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.network(
                            product.image ?? '',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title ?? '',
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
                              "\$${product.price}",
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${product.rating?.rate}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "(${product.rating?.count})",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
