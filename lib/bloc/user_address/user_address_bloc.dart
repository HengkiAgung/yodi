import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/address_model.dart';
import '../../repository/user_repository.dart';
import '../../utils/auth.dart';

part 'user_address_event.dart';
part 'user_address_state.dart';

class UserAddressBloc extends Bloc<UserAddressEvent, UserAddressState> {
  final UserRepository userRepository;
  
  UserAddressBloc({required this.userRepository}) : super(UserAddressInitial()) {
    on<GetAllAddressData>((event, emit) async {
      emit(UserAddressLoading());
      try {
        String? token = await Auth().getToken();
        final address = await userRepository.getAllUserAddress(token!);

        emit(UserAddressLoadSuccess(address));
      } catch (error) {
        emit(UserAddressLoadFailure(error: error.toString()));
      }
    });
  }
}
