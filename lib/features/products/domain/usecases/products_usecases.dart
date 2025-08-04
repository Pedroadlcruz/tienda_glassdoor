import '../../data/models/product.dart';
import '../repositories/products_repository.dart';

class ProductsUseCases {
  final ProductsRepository _productsRepository;

  ProductsUseCases(this._productsRepository);

  Future<List<Product>> getAllProducts() {
    return _productsRepository.getProducts();
  }

  Future<Product?> getProductById(String id) {
    return _productsRepository.getProductById(id);
  }

  Future<List<Product>> getProductsByCategory(String category) {
    return _productsRepository.getProductsByCategory(category);
  }

  Future<List<Product>> searchProducts(String query) {
    return _productsRepository.searchProducts(query);
  }
}
