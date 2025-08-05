part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {
  final ProductCategory? selectedCategory;

  const ProductsLoading({this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final ProductCategory selectedCategory;
  final String? searchQuery;

  const ProductsLoaded({
    required this.products,
    this.selectedCategory = ProductCategory.all,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, selectedCategory, searchQuery];
}

final class ProductsError extends ProductsState {
  final String message;
  final ProductCategory? selectedCategory;

  const ProductsError(this.message, {this.selectedCategory});

  @override
  List<Object?> get props => [message, selectedCategory];
}
