part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends UserEvent {
  final String idUser;

  const GetUserData({required this.idUser});
}

class Login extends UserEvent {
  final String email;
  final String password;

  const Login({required this.email, required this.password});
}

class Register extends UserEvent {
  final String username;
  final String email;
  final String password;

  const Register({required this.username, required this.email, required this.password});
}