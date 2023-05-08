part of 'user_address_bloc.dart';

abstract class UserAddressState extends Equatable {
  const UserAddressState();
  
  @override
  List<Object> get props => [];
}

class UserAddressInitial extends UserAddressState {}


class UserAddressLoading extends UserAddressState {}

class UserAddressLoadSuccess extends UserAddressState {
  final List<Address> address;

  const UserAddressLoadSuccess(this.address);
}

class UserAddressLoadFailure extends UserAddressState {
  final String error;

  const UserAddressLoadFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Failed to load fish {error: $error}';
  }
}