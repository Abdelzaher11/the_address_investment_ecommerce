import 'package:dartz/dartz.dart';
import 'package:the_address_investments_ecommerce/features/home/domain/entities/category_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/entities/product_entity.dart';
import '../repositories/home_repo.dart';

class HomeUseCase {
  final HomeRepo homeRepo;

  HomeUseCase({required this.homeRepo});

  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    return await homeRepo.getProducts();
  }

  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    return await homeRepo.getCategories();
  }
  Future<Either<Failure, ProductEntity>> updateProduct({required int id, required Map<String, dynamic> updatedProductData}) async {
    return await homeRepo.updateProduct(id: id,updatedProductData: updatedProductData,);
  }
}
