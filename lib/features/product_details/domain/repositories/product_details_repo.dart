import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/core/entities/product_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class ProductDetailsRepo {
  Future<Either<Failure, ProductEntity>> getProductDetails({required int id}); 
  Future<Either<Failure, Unit>> addProductToCart({required int productId}); 
}