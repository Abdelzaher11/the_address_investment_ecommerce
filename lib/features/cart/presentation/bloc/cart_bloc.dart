// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address_investments_ecommerce/core/entities/cart_product_entity.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/core/extensions/emit_extension.dart';
import 'package:the_address_investments_ecommerce/core/helpers/hive_cache_helper.dart';
import 'package:the_address_investments_ecommerce/features/cart/domain/use_cases/cart_use_case.dart';

import '../../../../core/errors/failure.dart';

part 'cart_states.dart';
part 'cart_events.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc({required this.cartUseCase}) : super(CartInitialState());

  CartUseCase cartUseCase;

  List<ProductEntity> products = [];
  List<CartProductEntity> cartProducts = [];
  int subTotal = 0;
  int total = 0;
  int shippingCost = 20;

  /// Initializes the [CartBloc] by loading the cart from the local database.
  ///
  /// This method is called when the [CartBloc] is created.
  Future<void> init() async {
    /// Load the cart from the local database.
    await loadCart();
  }

  Future<void> loadCart() async {
    safeEmit(CartLoadingState());
    final Either<Failure, List<CartProductEntity>> result = await cartUseCase.getCartProducts();
    /// Handles the result of [CartUseCase.getCartProducts].
    ///
    /// If the result is a [Left] (failure), it emits a [CartFailureState] with the error message.
    /// If the result is a [Right] (success), it loads the products from the local database,
    /// calculates the subtotal and total, and emits a [CartSuccessState].
    return result.fold(
      (failure) {
        safeEmit(CartFailureState(message: failure.message));
      },
      (success) async {
        /// Load the products from the local database.
        cartProducts = success;
        await Future.forEach(cartProducts, (cartProduct) async {
          final ProductEntity? _product =
              await HiveCacheHelper.getItem<ProductEntity>(HiveBoxes.productsBox, cartProduct.id);
          if (_product != null) {
            /// Add the product to the list of products.
            products.add(_product);
            /// Calculate the subtotal and total.
            subTotal += _product.price * cartProduct.quantity;
          }
        });
        total = subTotal + shippingCost;
        safeEmit(CartSuccessState());
      },
    );
  }

  /// Deletes a product from the cart.
  ///
  /// This method emits a [DeleteProductLoadingState] initially, to indicate that the operation is in progress.
  /// It then emits a [DeleteProductFailureState] or [DeleteProductSuccessState], depending on the result of the operation.
  ///
  /// If the operation is successful, it removes the product from the cart and from the list of products.
  /// It then recalculates the subtotal and total, and emits a [DeleteProductSuccessState] with the updated lists of products and cart items.
  ///
  /// If the operation fails, it emits a [DeleteProductFailureState] with the error message.
  Future<void> deleteProduct({required int productID}) async {
    safeEmit(DeleteProductLoadingState());
    final Either<Failure, Unit> result = await cartUseCase.deleteProduct(productID: productID);
    return result.fold(
      (failure) {
        safeEmit(DeleteProductFailureState(message: failure.message));
      },
      (success) async {
        /// Remove the product from the cart and from the list of products.
        cartProducts.removeWhere(
          (element) => element.id == productID,
        );
        products.removeWhere(
          (element) => element.id == productID,
        );
        /// Recalculate the subtotal and total.
        await _recalculateOrderInfo();
        /// Emit a [DeleteProductSuccessState] with the updated lists of products and cart items.
        safeEmit(DeleteProductSuccessState(
          currentCartList: cartProducts,
          currentProductsList: products,
        ));
      },
    );
  }

  /// Increments the quantity of a product in the cart.
  ///
  /// This method emits a [CartProductOperationLoadingState] initially, to indicate that the operation is in progress.
  /// It then emits a [CartProductOperationFailureState] or [CartProductOperationSuccessState], depending on the result of the operation.
  ///
  /// If the operation is successful, it updates the quantity of the product in the cart,
  /// recalculates the order information, and emits a [CartProductOperationSuccessState] with the product ID.
  ///
  /// If the operation fails, it emits a [CartProductOperationFailureState] with the error message.
  Future<void> incrementQuantity({required int productID}) async {
    // Emit loading state to indicate the operation is in progress
    safeEmit(CartProductOperationLoadingState());

    // Call the use case to increment the quantity of the product
    final Either<Failure, CartProductEntity> result = await cartUseCase.incrementCount(productID: productID);
    
    // Handle the result of the increment operation
    return result.fold(
      (failure) {
        // Emit failure state with error message if the operation fails
        safeEmit(CartProductOperationFailureState(message: failure.message));
      },
      (success) async {
        // Update the cart with the new product quantity
        cartProducts[cartProducts.indexWhere((element) => element.id == productID)] = success;
        
        // Recalculate order information such as subtotal and total
        await _recalculateOrderInfo();
        
        // Emit success state with the updated product ID
        safeEmit(CartProductOperationSuccessState(productId: productID));
      },
    );
  }

  /// Decrements the quantity of a product in the cart.
  ///
  /// This method emits a [CartProductOperationLoadingState] initially, to indicate that the operation is in progress.
  /// It then emits a [CartProductOperationFailureState] or [CartProductOperationSuccessState], depending on the result of the operation.
  ///
  /// If the operation is successful, it updates the quantity of the product in the cart,
  /// recalculates the order information, and emits a [CartProductOperationSuccessState] with the product ID.
  ///
  /// If the operation fails, it emits a [CartProductOperationFailureState] with the error message.
  Future<void> decrementQuantity({required int productID}) async {
    // Emit loading state to indicate the operation is in progress
    safeEmit(CartProductOperationLoadingState());

    // Call the use case to decrement the quantity of the product
    final Either<Failure, CartProductEntity> result = await cartUseCase.decrementCount(productID: productID);

    // Handle the result of the decrement operation
    return result.fold(
      // If the operation fails, emit failure state with error message
      (failure) {
        safeEmit(CartProductOperationFailureState(message: failure.message));
      },
      // If the operation is successful, update the cart and recalculate order information
      (success) async {
        // If the quantity of the product is not zero, update the quantity of the product in the cart
        if (success.quantity != 0) {
          cartProducts[cartProducts.indexWhere((element) => element.id == productID)] = success;
        }
        // If the quantity of the product is zero, remove the product from the cart and from the list of products
        else {
          cartProducts.removeWhere(
            (element) => element.id == productID,
          );
          products.removeWhere(
            (element) => element.id == productID,
          );
        }
        // Recalculate the order information
        await _recalculateOrderInfo();
        // Emit success state with the updated product ID if the cart is not empty
        if (cartProducts.isNotEmpty) {
          safeEmit(CartProductOperationSuccessState(productId: productID));
        }
        // Emit success state with the updated cart and list of products if the cart is empty
        if (cartProducts.isEmpty) {
          safeEmit(DeleteProductSuccessState(
            currentCartList: cartProducts,
            currentProductsList: products,
          ));
        }
      },
    );
  }

  /// Recalculates the order information such as subtotal and total.
  ///
  /// This method recalculates the subtotal and total of the order by iterating over the cart products,
  /// retrieving the product price from the products box, and multiplying the price by the quantity of the product.
  /// It then updates the [subTotal] and [total] fields with the calculated values.
  Future<void> _recalculateOrderInfo() async {
    // Reset the subtotal
    subTotal = 0;
    // Iterate over the cart products
    await Future.forEach(cartProducts, (cartProduct) async {
      // Retrieve the product from the products box
      final ProductEntity? _product =
          await HiveCacheHelper.getItem<ProductEntity>(HiveBoxes.productsBox, cartProduct.id);
      // If the product is found, add the product price multiplied by the quantity to the subtotal
      if (_product != null) {
        subTotal += _product.price * cartProduct.quantity;
      }
    });
    // Calculate the total by adding the shipping cost to the subtotal
    total = subTotal + shippingCost;
  }


  Future<void> confirmOrder() async {
    safeEmit(ConfirmOrderLoadingState());
    // Delete the cart box from the disk
    // This is done to reset the cart after a successful order confirmation
    await HiveCacheHelper.deleteBoxFromDisk(HiveBoxes.cartBox);
    // Emit a success state to indicate that the order has been confirmed successfully
    // This state is used to navigate to the home page after a successful order confirmation
    safeEmit(ConfirmOrderSuccessState());
  }
}

