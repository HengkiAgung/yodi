import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/user_model.dart';
import '../../repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<GetUserData>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUserData(event.idUser);

        emit(UserLoadSuccess(user));
      } catch (error) {
        emit(UserLoadFailure(error: error.toString()));
      }
    });
  }
}
