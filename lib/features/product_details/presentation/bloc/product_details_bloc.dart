import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address_investments_ecommerce/core/extensions/emit_extension.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/use_cases/product_details_use_case.dart';

part 'product_details_events.dart';
part 'product_details_states.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvents, ProductDetailsStates> {
  ProductDetailsBloc({required this.productDetailsUseCase}) : super(ProductDetailsInitialState());
  ProductDetailsUseCase productDetailsUseCase;

  ProductEntity product = ProductEntity.empty();

     /// Loads the details of a product by its [id].
  ///
  /// Emits a loading state before starting the fetch operation.
  /// Upon success, updates the [product] and emits a success state.
  /// Emits a failure state with an error message if the operation fails.
  Future<void> loadProductDetails({required int id}) async {
    // Emit a loading state to indicate the product details are being fetched
    safeEmit(ProductLoadingState());

    // Attempt to fetch product details using the use case
    final Either<Failure, ProductEntity> result = await productDetailsUseCase.getProductDetails(id: id);

    // Handle the result of the fetch operation
    result.fold(
      (failure) {
        // Emit a failure state with the error message if fetching fails
        safeEmit(ProductFailureState(message: failure.message));
      },
      (success) async {
        // Update the current product with the fetched details
        product = success;
        // Emit a success state indicating the product details have been loaded
        safeEmit(ProductSuccessState());
      },
    );
  }

     /// Adds a product to the cart by its [productId].
  ///
  /// Emits a loading state before starting the add operation.
  /// Upon success, emits a success state.
  /// Emits a failure state with an error message if the operation fails.
  Future<void> addProductToCart({required int productId}) async {
    // Emit a loading state to indicate the add to cart operation is in progress
    safeEmit(AddProductToCartLoadingState());

    // Attempt to add the product to the cart using the use case
    final Either<Failure, Unit> result = await productDetailsUseCase.addProductToCart(productId: productId);

    // Handle the result of the add operation
    result.fold(
      (failure) {
        // Emit a failure state with the error message if the operation fails
        safeEmit(AddProductToCartFailureState(message: failure.message));
      },
      (success) async {
        // Emit a success state indicating the product has been added to the cart
        safeEmit(AddProductToCartSuccessState());
      },
    );
  }

}
