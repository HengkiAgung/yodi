part of 'user_address_bloc.dart';

abstract class UserAddressEvent extends Equatable {
  const UserAddressEvent();

  @override
  List<Object> get props => [];
}

class GetAddressData extends UserAddressEvent {
  final Address address;
  
  const GetAddressData({required this.address});
}

class GetAllAddressData extends UserAddressEvent {}
