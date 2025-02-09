part of 'product_details_bloc.dart';

abstract class ProductDetailsStates extends Equatable{
  const ProductDetailsStates();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductLoadingState extends ProductDetailsStates {}

class ProductSuccessState extends ProductDetailsStates {}

class ProductFailureState extends ProductDetailsStates {
  const ProductFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class AddProductToCartLoadingState extends ProductDetailsStates {}

class AddProductToCartSuccessState extends ProductDetailsStates {}

class AddProductToCartFailureState extends ProductDetailsStates {
  const AddProductToCartFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}