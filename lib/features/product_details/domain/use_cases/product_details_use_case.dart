import 'package:dartz/dartz.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/product_details_repo.dart';

class ProductDetailsUseCase {
  ProductDetailsUseCase({required this.productDetailsRepo});
  ProductDetailsRepo productDetailsRepo;
  Future<Either<Failure, ProductEntity>> getProductDetails({required int id}) async =>
      productDetailsRepo.getProductDetails(id: id);
  Future<Either<Failure, Unit>> addProductToCart({required int productId}) async =>
      await productDetailsRepo.addProductToCart(productId: productId);
}
