import 'package:dartz/dartz.dart';

import '../../../../core/entities/cart_product_entity.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/cart_repo.dart';

class CartUseCase {
  CartRepo cartRepo;
  CartUseCase({required this.cartRepo});

  Future<Either<Failure, List<CartProductEntity>>> getCartProducts() async => await cartRepo.getCartProducts();
  Future<Either<Failure,CartProductEntity> > incrementCount({required int productID}) async => await cartRepo.incrementCount(productID: productID);
  Future<Either<Failure,CartProductEntity> > decrementCount({required int productID}) async => await cartRepo.decrementCount(productID: productID);
  Future<Either<Failure,Unit> > deleteProduct({required int productID}) async => await cartRepo.deleteProduct(productID: productID);
}
