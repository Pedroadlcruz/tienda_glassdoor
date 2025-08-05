part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadProducts extends ProductsEvent {}

final class LoadProductsByCategory extends ProductsEvent {
  final ProductCategory category;

  const LoadProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

final class SearchProducts extends ProductsEvent {
  final String query;
  final ProductCategory? category;

  const SearchProducts(this.query, {this.category});

  @override
  List<Object?> get props => [query, category];
}

final class SelectCategory extends ProductsEvent {
  final ProductCategory category;

  const SelectCategory(this.category);

  @override
  List<Object?> get props => [category];
}
