part of 'product_variant_bloc.dart';

abstract class ProductVariantEvent extends Equatable {
  const ProductVariantEvent();
  
  @override
  List<Object> get props => [];
}

class GetSelectedVariant extends ProductVariantEvent {}

class AddSelectedVariant extends ProductVariantEvent {
  final ProductVariant productVariant;

  const AddSelectedVariant({required this.productVariant});
}

