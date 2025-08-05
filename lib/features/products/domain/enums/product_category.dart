import '../../../../core/constants/strings.dart';

enum ProductCategory {
  all(Strings.allCategories),
  electronics(Strings.electronics),
  sports(Strings.sports),
  clothing(Strings.clothing),
  books(Strings.books),
  beauty(Strings.beauty),
  toys(Strings.toys);

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
    ProductCategory.beauty,
    ProductCategory.toys,
  ];

  @override
  String toString() => displayName;
}
