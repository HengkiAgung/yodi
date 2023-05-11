part of 'seller_bloc.dart';

abstract class SellerState extends Equatable {
  const SellerState();
  
  @override
  List<Object> get props => [];
}

class SellerInitial extends SellerState {}

class SellerLoading extends SellerState {}

class SellerLoadSuccess extends SellerState {
  final List<Seller> seller;

  const SellerLoadSuccess(this.seller);
}

class SellerLoadFailure extends SellerState {
  final String error;

  const SellerLoadFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'Failed to load fish {error: $error}';
  }
}