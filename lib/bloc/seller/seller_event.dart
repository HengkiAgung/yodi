part of 'seller_bloc.dart';

abstract class SellerEvent extends Equatable {
  const SellerEvent();

  @override
  List<Object> get props => [];
}

class GetSellerList extends SellerEvent {}

class GetTopSellerList extends SellerEvent {}

class GetSellerDetail extends SellerEvent {
  final String idSeller;

  const GetSellerDetail({required this.idSeller});
}