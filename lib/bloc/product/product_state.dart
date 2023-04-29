part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadSuccess extends ProductState {
  final List<Product> product;

  const ProductLoadSuccess(this.product);
}

class ProductLoadFailure extends ProductState {
  final String error;

  const ProductLoadFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Failed to load fish {error: $error}';
  }
}
