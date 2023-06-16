import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/product_variant_model.dart';

part 'product_variant_event.dart';
part 'product_variant_state.dart';

class ProductVariantBloc extends Bloc<ProductVariantEvent, ProductVariantState> {
  ProductVariantBloc() : super(ProductVariantInitial()) {
    // on<GetSelectedVariant>((event, emit) async {
    //   emit(ProductVariantInitial());
    //   try {
    //     emit(ProductVariantLoadSuccess(event.productVariants));
    //   } catch (e) {
    //     emit(ProductVariantLoadFailure(error: e.toString()));
    //   }
    // });

    on<AddSelectedVariant>((event, emit) async {
      emit(ProductVariantInitial());
      try {
        var variants = GetProductVariants().productVariants;
        variants.add(event.productVariant);

        emit(AddNewProductVariant(newProductVariant: variants));
      } catch (e) {
        emit(ProductVariantLoadFailure(error: e.toString()));
      }
    });
  }
}
