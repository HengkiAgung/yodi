part of 'product_variant_bloc.dart';

abstract class ProductVariantState extends Equatable {
  List<ProductVariant> productVariants = [];
  
  @override
  List<Object> get props => [];

  void addVariant(List<ProductVariant> variants){
    productVariants = variants;
  }
}

class ProductVariantInitial extends ProductVariantState {}

class ProductVariantLoading extends ProductVariantState {}

class ProductVariantLoadSuccess extends ProductVariantState {
  final List<ProductVariant> productVariant;

  ProductVariantLoadSuccess(this.productVariant);
}

class ProductVariantLoadFailure extends ProductVariantState {
  final String error;

  ProductVariantLoadFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Failed to load fish {error: $error}';
  }
}

class GetProductVariants extends ProductVariantState {
  List<ProductVariant> productVariant = [];

  GetProductVariants(){
    print("ini dari constructor get variant");
    productVariant = super.productVariants;
    print(productVariant);
  }
}

class AddNewProductVariant extends ProductVariantState {
  final List<ProductVariant> newProductVariant;

  AddNewProductVariant({required this.newProductVariant}) {
    print(newProductVariant);
    super.productVariants = newProductVariant;
    print(productVariants.length);
  }
}