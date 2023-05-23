part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartList extends CartEvent {}

class ShippingCart extends CartEvent {}

class PaymentCart extends CartEvent {}
