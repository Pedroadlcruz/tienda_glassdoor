import 'package:equatable/equatable.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadProducts extends ProductsEvent {}

final class LoadProductsByCategory extends ProductsEvent {
  final String category;

  const LoadProductsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

final class SearchProducts extends ProductsEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}
