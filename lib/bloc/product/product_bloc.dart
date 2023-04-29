import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/product_model.dart';
import '../../repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<GetProductList>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await productRepository.getProductData();
        // print(Product);
        emit(ProductLoadSuccess(product));
      } catch (error) {
        emit(ProductLoadFailure(error: error.toString()));
      }
    });
  }
}
