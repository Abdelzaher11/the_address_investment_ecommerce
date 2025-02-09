// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';
import 'package:the_address_investments_ecommerce/core/errors/exception.dart';
import 'package:the_address_investments_ecommerce/core/models/product_model.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/product_details_repo.dart';
import '../data_sources/local/add_product_to_cart_local_data_source.dart';
import '../data_sources/remote/product_details_remote_data_source.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo{
  ProductDetailsRepoImpl({required this.productDetailsRemoteDataSource,required this.addProductToCartLocalDataSource,});
  ProductDetailsRemoteDataSource productDetailsRemoteDataSource;
  AddProductToCartLocalDataSource addProductToCartLocalDataSource;
  @override
  Future<Either<Failure, ProductEntity>> getProductDetails({required int id}) async {
    try {
      final ProductModel _result = await productDetailsRemoteDataSource.getProductDetails(id: id,);
       final ProductEntity productEntity = _result.toEntity();
      return Right(productEntity);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> addProductToCart({required int productId}) async {
 try {
      await addProductToCartLocalDataSource.addProductToCart(productId: productId,);
      return const Right(unit);
    } catch (exception) {
      return Left(ErrorHandler.handleException(exception as Exception));
    }
  }
}