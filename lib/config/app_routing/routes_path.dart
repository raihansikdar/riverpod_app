// class RoutesPath{
//   static const String splashScreen = "/";
//   static const String loginScreen = "/login";
//   static const String homeScreen = "/home";
//   static const String categoryWiseProductScreen = "/categoryWishProduct/:categoryName";
//   static const String productDetailsScreen = "productDetails/:productId";
// }


class RoutesPath {
  //static const String splashScreen = "/";
 // static const String loginScreen = "/login";
  static const String homeScreen = "/";
  static const String categoryWiseProductBase = "categoryWishProduct";
  static const String productDetailsBase = "productDetails";
  static const String testScreen = "/test";

  static String categoryWiseProduct({ required String categoryName}) =>
      "/$categoryWiseProductBase/$categoryName";

  static String productDetails({required String categoryName,required int productId}) =>
      "/$categoryWiseProductBase/$categoryName/$productDetailsBase/$productId";
}