part of 'home_bloc.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeStates {}

class ProductsLoadingState extends HomeStates {}

class ProductsSuccessState extends HomeStates {}

class ProductsFailureState extends HomeStates {
  const ProductsFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class CategoriesLoadingState extends HomeStates {}

class CategoriesSuccessState extends HomeStates {}

class CategoriesFailureState extends HomeStates {
  const CategoriesFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeFailureState extends HomeStates {
  const HomeFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class ProductEditIsOpenedState extends HomeStates{
   const ProductEditIsOpenedState({required this.isOpened});
  final bool isOpened;
  @override
  List<Object?> get props => [isOpened];
}

class UpdateProductLoadingState extends HomeStates {}

class UpdateProductSuccessState extends HomeStates {
  const UpdateProductSuccessState({required this.id});
  final int id;
  @override
  List<Object?> get props => [id];
}

class UpdateProductFailureState extends HomeStates {
  const UpdateProductFailureState({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class PaginationLoadingState extends HomeStates {}
class PaginationFinishedState extends HomeStates {}