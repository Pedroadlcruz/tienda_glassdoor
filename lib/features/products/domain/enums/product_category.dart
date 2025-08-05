enum ProductCategory {
  all('Todos'),
  electronics('Electronics'),
  sports('Sports'),
  clothing('Clothing'),
  books('Books'),
  home('Home'),
  beauty('Beauty'),
  toys('Toys');

  const ProductCategory(this.displayName);

  final String displayName;

  static ProductCategory fromString(String value) {
    return ProductCategory.values.firstWhere(
      (category) => category.displayName == value || category.name == value,
      orElse: () => ProductCategory.all,
    );
  }

  static List<ProductCategory> get availableCategories => [
    ProductCategory.all,
    ProductCategory.electronics,
    ProductCategory.sports,
    ProductCategory.clothing,
    ProductCategory.books,
    ProductCategory.home,
    ProductCategory.beauty,
    ProductCategory.toys,
  ];

  @override
  String toString() => displayName;
} 