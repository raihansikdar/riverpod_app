class AppUrls{
  AppUrls._();

  static const String _baseUrl = "https://fakestoreapi.com";

  static const String allProducts = '$_baseUrl/products';
  static const String getAllCategoryUrl = '$_baseUrl/products/categories';
  static String getCategoryWiseProductUrl({required String categoryName}) => '$_baseUrl/products/category/$categoryName';
  static String getProductDetailsUrl({required int id}) => '$_baseUrl/products/$id';
}