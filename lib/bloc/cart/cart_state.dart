part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoadSuccess extends CartState {
  final List<Cart> carts;

  const CartLoadSuccess(this.carts);
}

class CartLoadFailure extends CartState {
  final String error;

  const CartLoadFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Failed to load fish {error: $error}';
  }
}