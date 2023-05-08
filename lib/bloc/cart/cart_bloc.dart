import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/cart_model.dart';
import '../../repository/cart_repository.dart';
import '../../utils/auth.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<GetCartList>((event, emit) async {
      emit(CartLoading());
      try {
        String? token = await Auth().getToken();
        final product = await cartRepository.getCarts(token!);
        
        emit(CartLoadSuccess(product));
      } catch (error) {
        emit(CartLoadFailure(error: error.toString()));
      }
    });
  }
}
