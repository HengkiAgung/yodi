part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductList extends ProductEvent {}

class GetProductDetail extends ProductEvent {
  final String idProduct;

  const GetProductDetail({required this.idProduct});
}
