
import 'package:go_router/go_router.dart';
import 'package:riverpod_app/config/app_routing/routes_path.dart';
import 'package:riverpod_app/features/category_wise_product/views/screen/category_wise_product_screen.dart';
import 'package:riverpod_app/features/counter_and_change_button/views/counter_page.dart';
import 'package:riverpod_app/features/product/views/screen/product_screen.dart';

import '../../features/product_details/views/screen/product_details_csreen.dart';


class AppRouting {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RoutesPath.homeScreen,
    routes: [
      // GoRoute(
      //   path: RoutesPath.splashScreen,
      //   builder: (context, state) => SplashScreen(),
      // ),
      // GoRoute(
      //   path: RoutesPath.loginScreen,
      //   builder: (context, state) => LoginScreen(),
      // ),
      GoRoute(
        path: RoutesPath.homeScreen,
        builder: (context, state) => ProductScreen(),
        routes: [
          GoRoute(
            path: '${RoutesPath.categoryWiseProductBase}/:categoryName',
            //path: RoutesPath.categoryWiseProductScreen, // Now categoryWiseProduct/:categoryName
            builder: (context, state) {
              final categoryName = state.pathParameters['categoryName'] ?? '';
              return CategoryWiseProductScreen(categoryName: categoryName);
            },
            routes: [
              GoRoute(
                path: '${RoutesPath.productDetailsBase}/:productId',
                // path: RoutesPath.productDetailsScreen, // productDetails/:productId
                builder: (context, state) {
                  final productIdStr = state.pathParameters['productId'] ?? '0';
                  final productId = int.tryParse(productIdStr) ?? 0;
                  return ProductDetailsScreen(productId: productId);
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: RoutesPath.testScreen,
        builder: (context, state) => CounterPage(),
      ),
    ],
  );
}

