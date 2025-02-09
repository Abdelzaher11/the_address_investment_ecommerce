// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/core/extensions/emit_extension.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/use_cases/home_use_case.dart';

part 'home_events.dart';
part 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc({required this.homeUseCase}) : super(HomeInitialState());
  HomeUseCase homeUseCase;

  bool isEditing = false;
  final ScrollController scrollController = ScrollController();

  List<ProductEntity> productsOriginalList = [];
  List<ProductEntity> productsScreenList = [];
  List<CategoryEntity> categories = [];

  /// Initializes the home screen by loading products and categories.
  /// Emits a loading state before starting the operations, and based on the
  /// result, emits success or failure states accordingly.
  void init() async {
    // Emit loading state before starting to fetch data
    safeEmit(HomeLoadingState());
    
    // Load products and categories
    await loadProducts();
    await loadCategories();

    // Check for failure states and emit appropriate failure message
    if (state is ProductsFailureState) {
      final _message = (state as ProductsFailureState).message;
      safeEmit(HomeFailureState(message: _message));
    } else if (state is CategoriesFailureState) {
      final _message = (state as CategoriesFailureState).message;
      safeEmit(HomeFailureState(message: _message));
    } else {
      // Emit success state if no failures
      safeEmit(HomeSuccessState());
    }
  }

  Future<void> loadProducts() async {
    safeEmit(ProductsLoadingState());
    /// Loads products from the [HomeUseCase] and handles the result.
    /// If the result is a failure, emits a [ProductsFailureState] with the
    /// failure message.
    /// If the result is a success, emits a [ProductsSuccessState] and
    /// sets up the scroll controller to listen for scroll events.
    /// Also takes the first 20 products and sets them as the
    /// [productsScreenList].
    final Either<Failure, List<ProductEntity>> result =
        await homeUseCase.getProducts();
    result.fold(
      (failure) {
        safeEmit(ProductsFailureState(message: failure.message));
      },
      (success) async {
        productsOriginalList = success;
        productsScreenList = productsOriginalList
            .skip(productsScreenList.length)
            .take(20)
            .toList();
        _listenForScroll();
        safeEmit(ProductsSuccessState());
      },
    );
  }

  /// Loads categories from the [HomeUseCase] and handles the result.
  ///
  /// This function initiates the loading process by emitting a
  /// [CategoriesLoadingState]. It then calls the [homeUseCase.getCategories]
  /// method to fetch the list of categories. Depending on the result, it
  /// either emits a [CategoriesFailureState] with the error message in case of
  /// failure, or updates the [categories] list with the fetched categories and
  /// emits a [CategoriesSuccessState] on success.
  ///
  /// Returns:
  ///   - A [Future] that completes when the categories have been loaded and
  ///     the appropriate state has been emitted.
  Future<void> loadCategories() async {
    // Emit loading state to indicate categories are being loaded
    safeEmit(CategoriesLoadingState());

    // Fetch categories using the use case
    final Either<Failure, List<CategoryEntity>> result =
        await homeUseCase.getCategories();

    // Handle the result of the category fetching process
    return result.fold(
      (failure) {
        // Emit failure state with the error message if fetching fails
        safeEmit(CategoriesFailureState(message: failure.message));
      },
      (success) {
        // Update the categories list and emit success state if fetching succeeds
        categories = success;
        safeEmit(CategoriesSuccessState());
      },
    );
  }

  /// Toggles the [isEditing] flag and emits a [ProductEditIsOpenedState]
  /// with the updated value.
  ///
  /// This method is used to open and close the edit mode for the products.
  void openEdit() {
    isEditing = !isEditing;
    safeEmit(ProductEditIsOpenedState(isOpened: isEditing));
  }

  /// Listens for scroll events on the [scrollController] and loads the next page
  /// of products if the end of the list is reached.
  ///
  /// This method is used to implement pagination for the products list.
  void _listenForScroll() {
    // Add a listener to the scroll controller to detect when the end of the list is reached
    scrollController.addListener(
      () async {
        // Check if the user has scrolled to the end of the list
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (productsScreenList.length != productsOriginalList.length) {
            // Emit a [PaginationLoadingState] to indicate that the next page is being loaded
            safeEmit(PaginationLoadingState());
            // Wait for 2 seconds to imitate a network request
            await Future.delayed(const Duration(seconds: 2));
            // Get the next page of products
            final List<ProductEntity> _paginatedList = productsOriginalList
                .skip(productsScreenList.length)
                .take(20)
                .toList();
            // Add the new products to the list of displayed products
            productsScreenList.addAll(_paginatedList);
            // Emit a [PaginationFinishedState] to indicate that the next page has been loaded
            safeEmit(PaginationFinishedState());
          }
        }
      },
    );
  }

  Future<void> updateProduct(
      {required int id,
      required Map<String, dynamic> updatedProductData}) async {
    // Emit loading state to indicate the update operation is in progress
    safeEmit(UpdateProductLoadingState());

    // Call the use case to update the product with the provided data
    final Either<Failure, ProductEntity> result =
        await homeUseCase.updateProduct(
      id: id,
      updatedProductData: updatedProductData,
    );

    // Handle the result of the update operation
    return result.fold(
      // If the operation fails, emit failure state with error message
      (failure) {
        safeEmit(UpdateProductFailureState(message: failure.message));
      },
      // If the operation is successful, update the product lists and emit success state
      (success) {
        // Update the original product list with the updated product
        productsOriginalList[productsOriginalList
            .indexWhere((element) => element.id == id)] = success;
        // Update the screen product list with the updated product
        productsScreenList[productsScreenList
            .indexWhere((element) => element.id == id)] = success;
        // Emit success state with the updated product ID
        safeEmit(UpdateProductSuccessState(id: id));
      },
    );
  }

  @override

  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
