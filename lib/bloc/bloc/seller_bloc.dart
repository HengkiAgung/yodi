import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/seller_model.dart';
import '../../repository/seller_repository.dart';

part 'seller_event.dart';
part 'seller_state.dart';

class SellerBloc extends Bloc<SellerEvent, SellerState> {
  final SellerRepository sellerRepository;

  SellerBloc({required this.sellerRepository}) : super(SellerInitial()) {
    on<GetSellerList>((event, emit) async {
      emit(SellerLoading());
      try {
        final seller = await sellerRepository.getSellers();

        print("seller dapat");
        print(seller);

        emit(SellerLoadSuccess(seller));
      } catch (error) {
        print(error);
        emit(SellerLoadFailure(error: error.toString()));
      }
    });
  }
}
