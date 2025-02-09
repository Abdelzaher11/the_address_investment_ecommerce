// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/core/entities/cart_product_entity.dart';
import 'package:the_address_investments_ecommerce/core/errors/exception.dart';
import 'package:the_address_investments_ecommerce/core/errors/failure.dart';
import 'package:the_address_investments_ecommerce/features/cart/domain/repositories/cart_repo.dart';

import '../../../../core/errors/error_handler.dart';
import '../data_sources/cart_operation_local_data_source.dart';
import '../data_sources/load_cart_local_data_source.dart';

class CartRepoImpl implements CartRepo{
  LoadCartLocalDataSource loadCartLocalDataSource;
  CartOperationLocalDataSource cartOperationLocalDataSource;
  CartRepoImpl({required this.loadCartLocalDataSource,required this.cartOperationLocalDataSource});
  @override
  Future<Either<Failure, List<CartProductEntity>>> getCartProducts() async {
     try {
      final List<CartProductEntity> _result = await loadCartLocalDataSource.getCartProducts();
      return Right(_result);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
  
  @override
  Future<Either<Failure, CartProductEntity>> decrementCount({required int productID}) async {
     try {
      final CartProductEntity _result = await cartOperationLocalDataSource.decrementProductQuantity(productId: productID);
      return Right(_result);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> deleteProduct({required int productID}) async {
     try {
      await cartOperationLocalDataSource.deleteProduct(productId: productID);
      return const Right(unit);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
  
  @override
  Future<Either<Failure, CartProductEntity>> incrementCount({required int productID}) async {
     try {
      final CartProductEntity _result = await cartOperationLocalDataSource.incrementProductQuantity(productId: productID);
      return Right(_result);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
}