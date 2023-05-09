part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class GetSellerList extends SellerEvent {}