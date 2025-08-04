import '../../data/models/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts();

  Future<Product?> getProductById(String id);

  Future<List<Product>> getProductsByCategory(String category);

  Future<List<Product>> searchProducts(String query);
}
