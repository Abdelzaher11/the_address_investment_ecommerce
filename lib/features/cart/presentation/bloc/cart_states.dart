part of 'cart_bloc.dart';

abstract class CartStates extends Equatable {
  const CartStates();
  @override
  List<Object?> get props => [];
}

class CartInitialState extends CartStates {}

class CartLoadingState extends CartStates {}
class CartSuccessState extends CartStates {}
class CartFailureState extends CartStates {
  const CartFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class CartProductOperationLoadingState extends CartStates {}
class CartProductOperationSuccessState extends CartStates {
  const CartProductOperationSuccessState({required this.productId});
  final int productId;
  @override
  List<Object?> get props => [productId];
}
class CartProductOperationFailureState extends CartStates {
  const CartProductOperationFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class DeleteProductLoadingState extends CartStates {}
class DeleteProductSuccessState extends CartStates {
  const DeleteProductSuccessState({required this.currentCartList,required this.currentProductsList});
  final List<ProductEntity> currentProductsList;
  final List<CartProductEntity> currentCartList;
  @override
  List<Object?> get props => [currentCartList,currentProductsList];
}
class DeleteProductFailureState extends CartStates {
  const DeleteProductFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}


class ConfirmOrderLoadingState extends CartStates {}
class ConfirmOrderSuccessState extends CartStates {}