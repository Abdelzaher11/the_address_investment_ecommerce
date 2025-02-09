import 'package:dartz/dartz.dart';

import '../../../../core/entities/cart_product_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class CartRepo {
  Future<Either<Failure,List<CartProductEntity>> > getCartProducts();
  Future<Either<Failure,CartProductEntity> > incrementCount({required int productID});
  Future<Either<Failure,CartProductEntity> > decrementCount({required int productID});
  Future<Either<Failure,Unit> > deleteProduct({required int productID});

}