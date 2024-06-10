import 'package:dev_template/product/core/model/products.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
}

final class ProductsState extends Equatable {
  const ProductsState({
    required this.status,
    this.products = const <Products>[],
    this.error = '',
  });

  final ProductStatus status;
  final List<Products> products;
  final String error;

  @override
  List<Object> get props => [status, products, error];

  ProductsState copyWith({
    ProductStatus? status,
    List<Products>? products,
    String? error,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error ?? this.error,
    );
  }
}
